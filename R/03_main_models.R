# SPDX-License-Identifier: GPL-3.0-or-later
# Main regression models for v42 (% of infant deaths attributed to low birth weight).
#
# M1  Original specification with correctly constructed crop indices, pooled OLS, nitrate sample
#     (SEs: iid / HC1 / clustered by state)
# M1b M1 without nitrate (full sample): the effect of the nitrate listwise deletion
# M2  Reduced spec (VIF-driven: drop v16, per-capita GDP and beds) + year and zone fixed effects
# M3  District and year fixed effects (within estimator): only time-varying regressors
# M4  M2 + Census 2011 / NFHS-4 district controls (districts that exist in Census 2011)
# M5  M3 with lagged yield shocks and monsoon anomalies (harvest in t-1 -> births in t)
#
# Sample: district-years with v42 below mean + 3 sd (the original rule); 04_robustness.R varies it.
# Crop indices enter as "index if the category is grown, 0 otherwise" plus a grown dummy, so districts
# that do not grow a category stay in the sample without being treated as zero-yield.
source("R/00_setup.R")
suppressPackageStartupMessages({ library(fixest); library(modelsummary); library(car) })

p <- build_model_data(load_panel())
d <- trim_sample(p, "v42", "mean3sd")
cat(sprintf("trim: keeps %d of %d district-years\n", nrow(d), nrow(p)))

models <- lapply(names(SPEC_RHS), function(s) feols(spec_formula("v42", s), data = d, cluster = ~state))
names(models) <- SPEC_NAMES[names(SPEC_RHS)]
m1 <- models[[1]]

# --- VIF for the original-style specification (M1), on an lm fit ---
v <- vif(lm(spec_formula("v42", "m1"), data = d))
vif_tab <- data.table(term = names(v), VIF = as.numeric(v))[order(-VIF)]
vif_tab[, label := ifelse(is.na(COEF_MAP[term]), term, COEF_MAP[term])]
write_md_table(vif_tab[, .(term, label, VIF)], file.path(TABLES_DIR, "vif_m1.md"), digits = 3,
               title = "Variance inflation factors, model M1",
               notes = "v15/v16 (r = 0.94) and log GDP / log beds (r = 0.93) are the collinear pairs; M2-M5 drop v16 and use per-capita GDP and beds.")

# --- M1 with three SE treatments ---
se_tab <- rbindlist(list(
  as.data.table(tidy_fixest(m1, vcov = "iid"))[, se := "iid"],
  as.data.table(tidy_fixest(m1, vcov = "hetero"))[, se := "HC1"],
  as.data.table(tidy_fixest(m1))[, se := "cluster_state"]
))
se_wide <- dcast(se_tab, term + estimate ~ se, value.var = c("std_error", "p_value"))
setcolorder(se_wide, c("term", "estimate", "std_error_iid", "p_value_iid", "std_error_HC1", "p_value_HC1",
                       "std_error_cluster_state", "p_value_cluster_state"))
se_wide[, label := ifelse(is.na(COEF_MAP[term]), term, COEF_MAP[term])]
write_md_table(se_wide, file.path(TABLES_DIR, "m1_se_comparison.md"), digits = 4,
               title = "M1: same point estimates, three standard-error treatments",
               notes = c(sprintf("N = %d; %d state clusters.", nobs(m1), uniqueN(d[obs(m1)]$state)),
                         "gdp, beds, child_marriage and nitrate vary only at the state(-year) level and the original model's residuals are heteroskedastic,",
                         "so the state-clustered column is the one to read."))

# --- main table ---
write_models_md(models, output = file.path(TABLES_DIR, "main_models.md"), coef_map = COEF_MAP, gof_map = GOF_MAP, stars = STARS,
             title = "Determinants of the LBW share of infant deaths (v42). Standard errors clustered by state.",
             notes = c("Sample: district-years with v42 below mean + 3 sd. Crop indices are tonnes/ha for the category when grown, 0 otherwise, with a grown dummy.",
                       "M3 and M5 absorb every time-invariant district and state variable (beds, tap, nitrate, Census, NFHS)."))

tidy_all <- rbindlist(lapply(names(models), function(nm) as.data.table(tidy_fixest(models[[nm]]))[, model := nm]))
tidy_all[, label := ifelse(is.na(COEF_MAP[term]), term, COEF_MAP[term])]
fwrite_stable(tidy_all, file.path(TABLES_DIR, "main_models_tidy.csv"))

fit <- data.table(model = names(models), N = sapply(models, nobs),
                  states = sapply(models, function(m) uniqueN(d[obs(m)]$state)),
                  districts = sapply(models, function(m) uniqueN(d[obs(m)]$districtlgdcode)),
                  adj_r2 = sapply(models, function(m) r2(m, "ar2")),
                  within_r2 = sapply(models, function(m) r2(m, "wr2")))
write_md_table(fit, file.path(TABLES_DIR, "main_models_fit.md"), digits = 4, title = "Sample and fit by model")
print(fit)
cat("main models written\n")
