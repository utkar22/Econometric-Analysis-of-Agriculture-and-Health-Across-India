# SPDX-License-Identifier: GPL-3.0-or-later
# Shared setup for the analysis scripts. Every script is run from the repository root:
#   Rscript R/03_main_models.R
suppressPackageStartupMessages({
  library(data.table)
})

PANEL_PATH  <- "data/processed/panel.csv"
RAW_PATH    <- "data/raw/main_final.csv"
TABLES_DIR  <- "outputs/tables"
FIGURES_DIR <- "outputs/figures"
dir.create(TABLES_DIR, showWarnings = FALSE, recursive = TRUE)
dir.create(FIGURES_DIR, showWarnings = FALSE, recursive = TRUE)
set.seed(20260912)

load_panel <- function() {
  p <- fread(PANEL_PATH)
  p[, `:=`(year_f = factor(year), zone = factor(zone), state = factor(state),
           district_id = factor(districtlgdcode))]
  p
}

# Outcome names used across scripts
OUTCOMES <- c(v42 = "LBW deaths (% of infant deaths)", v40 = "Sepsis", v43 = "Pneumonia",
              v44 = "Diarrhoea", v45 = "Fever", v46 = "Measles")

# Human-readable labels for coefficient tables
LABELS <- c(
  v12 = "v12 discharged <48h (%)", v15 = "v15 institutional deliveries (%)",
  v16 = "v16 safe deliveries (%)", v25 = "v25 live births (%)",
  v28 = "v28 newborns <2.5 kg (%)", female_pct = "Female share of births (%)",
  log_gdp = "log state GDP", log_beds = "log state beds", log_tap = "log tap-water HH (%)",
  log_gdp_pc = "log state GDP per capita", beds_per_lakh = "State beds per 100k",
  child_marriage = "Child-marriage cases (state count)", child_marriage_per_mn = "Child-marriage cases per mn",
  nitrate = "Nitrate (state)", nitrate_missing = "Nitrate missing (1/0)",
  yi_kharif_cash = "Kharif cash-crop yield index", yi_kharif_cereal = "Kharif cereal yield index",
  yi_rabi_cash = "Rabi cash-crop yield index", yi_rabi_cereal = "Rabi cereal yield index",
  lyi_kharif_all = "Kharif log yield (area-wtd)", lyi_rabi_all = "Rabi log yield (area-wtd)",
  yidev_kharif_all = "Kharif yield shock", yidev_rabi_all = "Rabi yield shock",
  yidev_kharif_cereal = "Kharif cereal yield shock", yidev_rabi_cereal = "Rabi cereal yield shock",
  yidev_kharif_cash = "Kharif cash yield shock", yidev_rabi_cash = "Rabi cash yield shock",
  rain_jjas_anom = "Monsoon rainfall anomaly (z)", rain_jjas_anom_lag1 = "Monsoon anomaly, t-1 (z)",
  lit_rate = "Literacy rate 2011 (%)", f_lit_rate = "Female literacy 2011 (%)", urban_share = "Urban share 2011 (%)",
  sc_st_share = "SC+ST share 2011 (%)", agri_worker_share = "Agricultural workers 2011 (%)",
  nfhs_women_anaemic = "NFHS-4 women anaemic (%)", nfhs_married_before18 = "NFHS-4 married <18 (%)",
  nfhs_anc4_visits = "NFHS-4 4+ ANC visits (%)", nfhs_women_bmi_low = "NFHS-4 women BMI<18.5 (%)",
  share_foodgrain_area = "Foodgrain share of area", hhi_area = "Crop concentration (HHI)"
)

# Write a data.frame as a GitHub-flavoured markdown table
write_md_table <- function(df, path, digits = 4, title = NULL, notes = NULL) {
  df <- as.data.frame(df)
  fmt <- function(x) {
    if (!is.numeric(x)) return(ifelse(is.na(x), "", as.character(x)))
    whole <- all(is.na(x) | abs(x - round(x)) < 1e-9)
    if (whole) ifelse(is.na(x), "", sprintf("%.0f", x)) else ifelse(is.na(x), "", formatC(x, digits = digits, format = "g"))
  }
  cells <- as.data.frame(lapply(df, fmt), stringsAsFactors = FALSE)
  header <- paste0("| ", paste(names(df), collapse = " | "), " |")
  sep <- paste0("|", paste(rep("---", ncol(df)), collapse = "|"), "|")
  body <- apply(cells, 1, function(r) paste0("| ", paste(r, collapse = " | "), " |"))
  out <- c(if (!is.null(title)) c(paste0("# ", title), ""), header, sep, body,
           if (!is.null(notes)) c("", notes))
  writeLines(out, path)
  invisible(path)
}

# fixest coefficient table -> tidy data.frame (est, se, p) for markdown output
tidy_fixest <- function(m, vcov = NULL) {
  ct <- if (is.null(vcov)) fixest::coeftable(m) else fixest::coeftable(m, vcov = vcov)
  data.frame(term = rownames(ct), estimate = ct[, 1], std_error = ct[, 2], p_value = ct[, 4],
             row.names = NULL, check.names = FALSE)
}

stars <- function(p) ifelse(p < 0.001, "***", ifelse(p < 0.01, "**", ifelse(p < 0.05, "*", "")))

# Estimates differ in their last bits between platforms (BLAS differences, and the fixed-effects demeaning
# converging fractionally differently), which changes the text `fwrite` produces even though the numbers agree
# to any precision that is read. Rounding to 6 significant digits keeps the committed CSVs byte-identical
# across machines; the tables in outputs/ report 3.
fwrite_stable <- function(dt, path, digits = 6) {
  dt <- data.table::copy(as.data.table(dt))
  num <- names(dt)[vapply(dt, is.numeric, logical(1))]
  if (length(num)) dt[, (num) := lapply(.SD, signif, digits = digits), .SDcols = num]
  data.table::fwrite(dt, path)
}

# ---------------------------------------------------------------------------------------------
# Model sample and specifications shared by 03_main_models.R, 04_robustness.R, 05_other_outcomes.R
# ---------------------------------------------------------------------------------------------

# Adds 0-filled crop indices with grown dummies and one-year lags of the season-level yields.
build_model_data <- function(p) {
  for (v in c("yi_kharif_cash", "yi_kharif_cereal", "yi_rabi_cash", "yi_rabi_cereal")) {
    set(p, j = paste0(v, "_0"), value = fifelse(is.na(p[[v]]), 0, p[[v]]))
    set(p, j = paste0("grows_", sub("yi_", "", v)), value = as.integer(!is.na(p[[v]])))
  }
  setorder(p, districtlgdcode, year)
  p[, `:=`(lyi_kharif_all_lag1 = shift(lyi_kharif_all), lyi_rabi_all_lag1 = shift(lyi_rabi_all),
           yidev_kharif_all_lag1 = shift(yidev_kharif_all), yidev_rabi_all_lag1 = shift(yidev_rabi_all),
           year_prev = shift(year)), by = districtlgdcode]
  p[is.na(year_prev) | year_prev != year - 1,
    c("lyi_kharif_all_lag1", "lyi_rabi_all_lag1", "yidev_kharif_all_lag1", "yidev_rabi_all_lag1") := NA_real_]
  p[, post2014 := as.integer(year >= 2014)]
  p
}

# Trimming rules for a bounded-share outcome. "mean3sd" is the original one-sided rule.
trim_sample <- function(p, outcome = "v42", rule = c("mean3sd", "none", "pct99")) {
  rule <- match.arg(rule)
  x <- p[[outcome]]
  keep <- switch(rule,
                 mean3sd = x < mean(x) + 3 * sd(x),
                 none = rep(TRUE, length(x)),
                 pct99 = x >= quantile(x, 0.01) & x <= quantile(x, 0.99))
  p[keep]
}

CROP_TERMS <- "yi_kharif_cash_0 + grows_kharif_cash + yi_kharif_cereal_0 + grows_kharif_cereal + yi_rabi_cash_0 + grows_rabi_cash + yi_rabi_cereal_0 + grows_rabi_cereal"
HEALTH     <- "v12 + v15 + v16 + v25 + v28 + female_pct"
HEALTH_R   <- "v12 + v15 + v25 + v28 + female_pct"   # v16 dropped: r = 0.94 with v15
CENSUS_NFHS <- "lit_rate + urban_share + sc_st_share + agri_worker_share + nfhs_women_anaemic + nfhs_married_before18 + nfhs_anc4_visits + nfhs_women_bmi_low"

# Right-hand sides (fixest syntax: regressors | fixed effects)
SPEC_RHS <- list(
  m1  = paste(HEALTH, "+ log_gdp + log_beds + log_tap + child_marriage + nitrate +", CROP_TERMS),
  m1b = paste(HEALTH, "+ log_gdp + log_beds + log_tap + child_marriage +", CROP_TERMS),
  m2  = paste(HEALTH_R, "+ log_gdp_pc + beds_per_lakh + log_tap + child_marriage_per_mn +", CROP_TERMS, "| year_f + zone"),
  m3  = paste(HEALTH_R, "+ log_gdp_pc + child_marriage_per_mn + yidev_kharif_all + yidev_rabi_all + rain_jjas_anom | district_id + year_f"),
  m4  = paste(HEALTH_R, "+ log_gdp_pc + beds_per_lakh + log_tap + child_marriage_per_mn +", CROP_TERMS, "+", CENSUS_NFHS, "| year_f + zone"),
  m5  = paste(HEALTH_R, "+ log_gdp_pc + child_marriage_per_mn + yidev_kharif_all + yidev_kharif_all_lag1 + yidev_rabi_all + yidev_rabi_all_lag1 + rain_jjas_anom + rain_jjas_anom_lag1 | district_id + year_f")
)
SPEC_NAMES <- c(m1 = "M1 original spec, corrected indices", m1b = "M1b no nitrate", m2 = "M2 year+zone FE",
                m3 = "M3 district+year FE", m4 = "M4 M2 + Census/NFHS", m5 = "M5 lags")
spec_formula <- function(outcome, spec) as.formula(paste(outcome, "~", SPEC_RHS[[spec]]))

# Coefficient labels for model tables
COEF_MAP <- c(LABELS[c("v12", "v15", "v16", "v25", "v28", "female_pct", "log_gdp", "log_beds", "log_tap", "child_marriage",
                       "nitrate", "log_gdp_pc", "beds_per_lakh", "child_marriage_per_mn")],
              yi_kharif_cash_0 = "Kharif cash-crop yield index", grows_kharif_cash = "Grows kharif cash crops (1/0)",
              yi_kharif_cereal_0 = "Kharif cereal yield index", grows_kharif_cereal = "Grows kharif cereals (1/0)",
              yi_rabi_cash_0 = "Rabi cash-crop yield index", grows_rabi_cash = "Grows rabi cash crops (1/0)",
              yi_rabi_cereal_0 = "Rabi cereal yield index", grows_rabi_cereal = "Grows rabi cereals (1/0)",
              yidev_kharif_all = "Kharif yield shock (log dev.)", yidev_kharif_all_lag1 = "Kharif yield shock, t-1",
              yidev_rabi_all = "Rabi yield shock (log dev.)", yidev_rabi_all_lag1 = "Rabi yield shock, t-1",
              rain_jjas_anom = "Monsoon rainfall anomaly (z)", rain_jjas_anom_lag1 = "Monsoon anomaly, t-1 (z)",
              lit_rate = "Literacy rate 2011 (%)", urban_share = "Urban share 2011 (%)", sc_st_share = "SC+ST share 2011 (%)",
              agri_worker_share = "Agricultural workers 2011 (%)", nfhs_women_anaemic = "NFHS-4 women anaemic (%)",
              nfhs_married_before18 = "NFHS-4 married <18 (%)", nfhs_anc4_visits = "NFHS-4 4+ ANC visits (%)",
              nfhs_women_bmi_low = "NFHS-4 women BMI<18.5 (%)")
GOF_MAP <- list(list(raw = "nobs", clean = "N", fmt = 0), list(raw = "r2.within", clean = "R2 within", fmt = 3),
                list(raw = "adj.r.squared", clean = "Adj. R2", fmt = 3), list(raw = "r.squared", clean = "R2", fmt = 3))
STARS <- c("*" = 0.05, "**" = 0.01, "***" = 0.001)

# modelsummary -> GitHub-flavoured pipe table (tinytable's markdown grid tables do not render on GitHub)
write_models_md <- function(models, output, coef_map = COEF_MAP, gof_map = GOF_MAP, stars = STARS, title = NULL, notes = NULL, fmt = 3) {
  df <- modelsummary::modelsummary(models, output = "data.frame", coef_map = coef_map, gof_map = gof_map, stars = stars, fmt = fmt)
  df <- as.data.frame(df)
  is_se <- df$part == "estimates" & df$statistic != "estimate"
  df$term[is_se] <- ""
  tab <- df[, !(names(df) %in% c("part", "statistic")), drop = FALSE]
  names(tab)[1] <- ""
  legend <- paste(sprintf("%s p < %s", names(stars), stars), collapse = ", ")
  write_md_table(tab, output, title = title, notes = c(paste0("Standard errors in parentheses. ", legend, "."), notes))
}
