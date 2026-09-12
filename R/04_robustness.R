# SPDX-License-Identifier: GPL-3.0-or-later
# Robustness checks for the v42 models:
#  (a) trimming rule: original mean+3sd, none, 1st-99th percentile           -> robustness_trimming.md
#  (b) fractional logit for M2 (outcome is a share), with average marginal effects -> robustness_fractional_logit.md
#  (c) cluster bootstrap by district (999 draws) for M2 and M3, replaces monte_carlo.R -> robustness_bootstrap.md
#  (d) structural break in 2014 (before_after.r replacement): Wald test on post-2014 interactions -> robustness_break2014.md
#  (e) rainfall as an instrument for the kharif yield shock in M3 -> robustness_iv.md
#  (f) state vs district clustering -> robustness_clustering.md
source("R/00_setup.R")
suppressPackageStartupMessages({ library(fixest); library(modelsummary) })

p <- build_model_data(load_panel())
d <- trim_sample(p, "v42", "mean3sd")
f2 <- spec_formula("v42", "m2"); f3 <- spec_formula("v42", "m3")

# (a) trimming ------------------------------------------------------------------------------------
tr <- list()
for (r in c("mean3sd", "none", "pct99")) {
  dd <- trim_sample(p, "v42", r)
  tr[[sprintf("M2 (%s, N=%d)", r, nrow(dd))]] <- feols(f2, dd, cluster = ~state)
  tr[[sprintf("M3 (%s, N=%d)", r, nrow(dd))]] <- feols(f3, dd, cluster = ~state)
}
write_models_md(tr, output = file.path(TABLES_DIR, "robustness_trimming.md"), coef_map = COEF_MAP, gof_map = GOF_MAP, stars = STARS,
             title = "Trimming rule for v42: original one-sided mean+3sd vs no trimming vs 1st-99th percentile. SEs clustered by state.")

# (b) fractional logit -------------------------------------------------------------------------------
d[, v42_frac := v42 / 100]
fl <- feglm(spec_formula("v42_frac", "m2"), data = d, family = binomial(link = "logit"), cluster = ~state)
eta <- predict(fl, type = "link")
scale <- mean(fl$family$mu.eta(eta)) * 100       # dP/dx in percentage points, averaged over the sample
ols <- feols(f2, d, cluster = ~state)
ct <- fixest::coeftable(fl)
fl_tab <- data.table(term = rownames(ct), logit_coef = ct[, 1], logit_se = ct[, 2], logit_p = ct[, 4],
                     AME_pct_points = ct[, 1] * scale)
fl_tab <- merge(fl_tab, data.table(term = names(coef(ols)), OLS_M2 = coef(ols), OLS_p = fixest::pvalue(ols)), by = "term", sort = FALSE)
fl_tab[, label := ifelse(is.na(COEF_MAP[term]), term, COEF_MAP[term])]
setcolorder(fl_tab, c("term", "label"))
write_md_table(fl_tab, file.path(TABLES_DIR, "robustness_fractional_logit.md"), digits = 4,
               title = "Fractional logit (Papke-Wooldridge) for M2, outcome v42/100, year + zone FE, SEs clustered by state",
               notes = c(sprintf("N = %d. AME = logit coefficient x mean(dP/deta) x 100, comparable to the OLS column (percentage points of v42).", nobs(fl)),
                         "A logit link keeps predictions inside [0, 100]; OLS does not. Agreement in sign and rough magnitude means the linear model is not misleading."))

# (c) cluster bootstrap by district ------------------------------------------------------------------
boot_fit <- function(f, dd, B = 999, fe_district = FALSE) {
  ids <- unique(dd$districtlgdcode)
  f_b <- if (fe_district) as.formula(gsub("district_id", "district_boot", deparse1(f))) else f
  base <- feols(f_b, dd[, district_boot := district_id], vcov = "iid")
  terms <- names(coef(base))
  est <- matrix(NA_real_, B, length(terms), dimnames = list(NULL, terms))
  for (b in seq_len(B)) {
    draw <- data.table(districtlgdcode = sample(ids, length(ids), replace = TRUE))[, boot_id := .I]
    bd <- dd[draw, on = "districtlgdcode", allow.cartesian = TRUE]
    bd[, district_boot := factor(boot_id)]
    cb <- coef(feols(f_b, bd, vcov = "iid"))
    est[b, names(cb)] <- cb
  }
  q <- apply(est, 2, quantile, probs = c(0.025, 0.975), na.rm = TRUE)
  data.table(term = terms, estimate = coef(base), boot_se = apply(est, 2, sd, na.rm = TRUE),
             boot_ci_low = q[1, ], boot_ci_high = q[2, ])
}
set.seed(20260912)
b2 <- boot_fit(f2, copy(d), fe_district = FALSE)[, model := "M2"]
b3 <- boot_fit(f3, copy(d), fe_district = TRUE)[, model := "M3"]
an <- rbindlist(list(as.data.table(tidy_fixest(ols))[, model := "M2"],
                     as.data.table(tidy_fixest(feols(f3, d, cluster = ~state)))[, model := "M3"]))
bt <- merge(rbindlist(list(b2, b3)), an[, .(model, term, cluster_state_se = std_error)], by = c("model", "term"))
bt[, `:=`(label = ifelse(is.na(COEF_MAP[term]), term, COEF_MAP[term]),
          excludes_zero = ifelse(boot_ci_low > 0 | boot_ci_high < 0, "yes", "no"))]
setcolorder(bt, c("model", "term", "label"))
write_md_table(bt, file.path(TABLES_DIR, "robustness_bootstrap.md"), digits = 4,
               title = "District cluster bootstrap (999 resamples of districts with replacement): percentile 95% CIs vs state-clustered SEs",
               notes = c("Districts are resampled with replacement; in M3 each drawn copy gets its own fixed effect.",
                         "This replaces the legacy monte_carlo.R, which dropped 20% of rows at random and compared mean coefficients without intervals."))

# (d) 2014 structural break ------------------------------------------------------------------------------
rhs2 <- sub("\\|.*$", "", SPEC_RHS$m2)
f_break <- as.formula(paste("v42 ~ (", rhs2, ") * post2014 | year_f + zone"))
mb <- feols(f_break, d, cluster = ~state)
w <- wald(mb, "post2014", print = FALSE)
inter <- as.data.table(tidy_fixest(mb))[grepl("post2014", term)]
inter[, base_term := sub(":?post2014:?", "", term)][, label := ifelse(is.na(COEF_MAP[base_term]), base_term, COEF_MAP[base_term])]
write_md_table(inter[, .(term = base_term, label, interaction_estimate = estimate, std_error, p_value)],
               file.path(TABLES_DIR, "robustness_break2014.md"), digits = 4,
               title = "Structural break at 2014: M2 with every regressor interacted with post2014 (year FE absorb the level shift)",
               notes = c(sprintf("Joint Wald test that all interactions are zero: F = %.3f, p = %.4f (clustered by state).", w$stat, w$p),
                         "Replaces legacy before_after.r, which fitted separate bivariate regressions before and after 2014."))

# (e) IV: monsoon anomaly instruments the kharif yield shock in M3 -------------------------------------------
f_iv <- as.formula(paste("v42 ~", HEALTH_R, "+ log_gdp_pc + child_marriage_per_mn + yidev_rabi_all | district_id + year_f | yidev_kharif_all ~ rain_jjas_anom"))
iv <- feols(f_iv, d, cluster = ~state)
fs <- fitstat(iv, ~ivf1 + ivwald1, verbose = FALSE)
f1 <- fs[[grep("^ivf1", names(fs))]]$stat; fw <- fs[[grep("^ivwald1", names(fs))]]$stat
m3 <- feols(f3, d, cluster = ~state)
iv_tab <- data.table(estimator = c("OLS (M3)", "2SLS"),
                     kharif_shock_estimate = c(coef(m3)["yidev_kharif_all"], coef(iv)["fit_yidev_kharif_all"]),
                     std_error = c(se(m3)["yidev_kharif_all"], se(iv)["fit_yidev_kharif_all"]),
                     p_value = c(pvalue(m3)["yidev_kharif_all"], pvalue(iv)["fit_yidev_kharif_all"]))
first <- as.data.table(tidy_fixest(iv$iv_first_stage$yidev_kharif_all))[term == "rain_jjas_anom"]
write_md_table(iv_tab, file.path(TABLES_DIR, "robustness_iv.md"), digits = 4,
               title = "Kharif yield shock instrumented by the state monsoon rainfall anomaly (district + year FE, SEs clustered by state)",
               notes = c(sprintf("First stage: rain_jjas_anom coefficient %.4f (SE %.4f); first-stage F = %.2f (clustered Wald F = %.2f).",
                                 first$estimate, first$std_error, f1, fw),
                         if (fw < 10) "Clustered first-stage F below 10: the instrument is weak and the 2SLS estimate is not interpreted." else
                           "Clustered first-stage F above 10; 2SLS is reported as the causal counterpart to M3.",
                         "Rainfall varies at the state-year level (36 IMD sub-divisions averaged to states)."))

# (f) clustering level -------------------------------------------------------------------------------------
cl <- list("M2 cluster: state" = feols(f2, d, cluster = ~state), "M2 cluster: district" = feols(f2, d, cluster = ~districtlgdcode),
           "M3 cluster: state" = feols(f3, d, cluster = ~state), "M3 cluster: district" = feols(f3, d, cluster = ~districtlgdcode))
write_models_md(cl, output = file.path(TABLES_DIR, "robustness_clustering.md"), coef_map = COEF_MAP, gof_map = GOF_MAP, stars = STARS,
             title = "Same estimates, standard errors clustered by state (33 clusters) or by district (673 clusters)")
cat("robustness tables written\n")
