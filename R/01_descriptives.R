# SPDX-License-Identifier: GPL-3.0-or-later
# Descriptive statistics for the district-year panel.
source("R/00_setup.R")
p <- load_panel()

vars <- c("v42", "v40", "v43", "v44", "v45", "v46", "v12", "v15", "v16", "v25", "v28", "female_pct",
          "gdp_pc", "beds_per_lakh", "tap", "child_marriage_per_mn", "nitrate",
          "yi_kharif_cash", "yi_kharif_cereal", "yi_rabi_cash", "yi_rabi_cereal",
          "lyi_kharif_all", "lyi_rabi_all", "yidev_kharif_all", "yidev_rabi_all",
          "rain_jjas", "rain_jjas_anom", "lit_rate", "urban_share", "sc_st_share", "agri_worker_share",
          "nfhs_women_anaemic", "nfhs_married_before18", "nfhs_anc4_visits", "nfhs_women_bmi_low",
          "share_foodgrain_area", "hhi_area")

summ <- rbindlist(lapply(vars, function(v) {
  x <- p[[v]]
  data.table(variable = v, label = ifelse(is.na(LABELS[v]), OUTCOMES[v], LABELS[v]),
             n = sum(!is.na(x)), mean = mean(x, na.rm = TRUE), sd = sd(x, na.rm = TRUE),
             min = min(x, na.rm = TRUE), median = median(x, na.rm = TRUE), max = max(x, na.rm = TRUE),
             share_zero = mean(x == 0, na.rm = TRUE))
}))
summ[is.na(label), label := variable]
write_md_table(summ, file.path(TABLES_DIR, "descriptives.md"), digits = 4,
               title = "Descriptive statistics, district-year panel (2011-2016)",
               notes = c(sprintf("Rows: %d district-years, %d districts, %d states.", nrow(p), uniqueN(p$districtlgdcode), uniqueN(p$state)),
                         "Sources and definitions: `data/processed/codebook.md`."))

# outcome means by year (unweighted district means)
by_year <- p[, lapply(.SD, mean, na.rm = TRUE), by = year, .SDcols = names(OUTCOMES)][order(year)]
setnames(by_year, names(OUTCOMES), paste0(names(OUTCOMES), ": ", OUTCOMES))
write_md_table(by_year, file.path(TABLES_DIR, "outcomes_by_year.md"), digits = 3,
               title = "Mean share of infant deaths by cause and year (district means)")

# child marriage cases per year (state counts, each state once per year)
cm <- unique(p[, .(state, year, child_marriage)])[, .(cases = sum(child_marriage)), by = year][order(year)]
write_md_table(cm, file.path(TABLES_DIR, "child_marriage_by_year.md"), digits = 5,
               title = "Reported child-marriage cases, sum over the 33 states/UTs in the data")

# correlations among the regressors used in the main model
corr_vars <- c("v12", "v15", "v16", "v25", "v28", "female_pct", "log_gdp", "log_beds", "log_tap",
               "log_gdp_pc", "beds_per_lakh", "child_marriage", "nitrate")
cm_mat <- cor(p[, ..corr_vars], use = "pairwise.complete.obs")
corr <- data.table(variable = rownames(cm_mat), round(cm_mat, 2))
write_md_table(corr, file.path(TABLES_DIR, "regressor_correlations.md"), digits = 2,
               title = "Pairwise correlations among regressors (pairwise complete observations)")

cat("descriptives written:", nrow(summ), "variables\n")
