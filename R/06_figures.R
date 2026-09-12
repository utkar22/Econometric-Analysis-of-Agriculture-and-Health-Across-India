# SPDX-License-Identifier: GPL-3.0-or-later
# Figures. Replaces the 12 per-outcome histogram scripts and the screenshots in legacy/Outputs.
source("R/00_setup.R")
suppressPackageStartupMessages({ library(ggplot2); library(fixest) })
theme_set(theme_minimal(base_size = 11))

p <- build_model_data(load_panel())

# 1. distribution of each cause-of-death share by year --------------------------------------------------
long <- melt(p[, c("year", names(OUTCOMES)), with = FALSE], id.vars = "year", variable.name = "outcome")
long[, outcome := factor(paste0(outcome, ": ", OUTCOMES[as.character(outcome)]), levels = paste0(names(OUTCOMES), ": ", OUTCOMES))]
g <- ggplot(long, aes(value, colour = factor(year))) +
  geom_freqpoly(binwidth = 2.5, linewidth = 0.5) +
  facet_wrap(~outcome, scales = "free_y") +
  coord_cartesian(xlim = c(0, 60)) +
  labs(x = "% of reported infant deaths", y = "district-years", colour = "year",
       title = "Cause-of-death shares across districts, by year (axis cut at 60%)")
ggsave(file.path(FIGURES_DIR, "outcomes_by_year.png"), g, width = 10, height = 6, dpi = 150)

# 2. child-marriage cases by year -----------------------------------------------------------------------
cm <- unique(p[, .(state, year, child_marriage)])[, .(cases = sum(child_marriage)), by = year]
g <- ggplot(cm, aes(factor(year), cases)) + geom_col(fill = "grey40") +
  labs(x = NULL, y = "reported cases (sum over states)", title = "Reported child-marriage cases, 33 states/UTs")
ggsave(file.path(FIGURES_DIR, "child_marriage_by_year.png"), g, width = 6, height = 4, dpi = 150)

# 3. coefficient plot across M1-M5 ----------------------------------------------------------------------
td <- fread(file.path(TABLES_DIR, "main_models_tidy.csv"))
keep <- c("v12", "v15", "v25", "v28", "female_pct", "log_gdp_pc", "child_marriage_per_mn",
          "yi_kharif_cash_0", "yi_kharif_cereal_0", "yi_rabi_cash_0", "yi_rabi_cereal_0",
          "yidev_kharif_all", "yidev_rabi_all", "rain_jjas_anom")
td <- td[term %in% keep]
td[, label := factor(label, levels = rev(unique(label)))]
td[, model := factor(model, levels = unname(SPEC_NAMES))]
g <- ggplot(td, aes(estimate, label, colour = model)) +
  geom_vline(xintercept = 0, colour = "grey60") +
  geom_pointrange(aes(xmin = estimate - 1.96 * std_error, xmax = estimate + 1.96 * std_error),
                  position = position_dodge(width = 0.6), size = 0.3) +
  facet_wrap(~label, scales = "free", ncol = 2) +
  theme(axis.text.y = element_blank(), strip.text = element_text(hjust = 0)) +
  labs(x = "coefficient on v42 (percentage points), 95% CI, SEs clustered by state", y = NULL, colour = NULL,
       title = "Selected coefficients across specifications")
ggsave(file.path(FIGURES_DIR, "coefficients_m1_m5.png"), g, width = 10, height = 9, dpi = 150)

# 4. monsoon anomaly vs kharif yield shock, both demeaned by district and year fixed effects (as in the IV first stage) ----
d <- trim_sample(p, "v42", "mean3sd")
iv_d <- d[!is.na(yidev_kharif_all) & !is.na(rain_jjas_anom)]
dm <- as.data.table(fixest::demean(X = as.matrix(iv_d[, .(rain_jjas_anom, yidev_kharif_all)]), f = iv_d[, .(district_id, year_f)]))
g <- ggplot(dm, aes(rain_jjas_anom, yidev_kharif_all)) +
  geom_point(alpha = 0.15, size = 0.7) + geom_smooth(method = "lm", colour = "firebrick", linewidth = 0.7) +
  coord_cartesian(ylim = c(-2, 2)) +
  labs(x = "monsoon (June-September) rainfall anomaly (z), net of district and year fixed effects",
       y = "kharif yield shock (log index minus district mean), net of district and year fixed effects",
       title = "IV first stage: within-district, within-year relationship (M3 sample)")
ggsave(file.path(FIGURES_DIR, "rain_vs_kharif_yield.png"), g, width = 7, height = 5, dpi = 150)

# 5. residual diagnostics for M2 ----
m2 <- feols(spec_formula("v42", "m2"), d, cluster = ~state)
png(file.path(FIGURES_DIR, "residuals_m2.png"), width = 1400, height = 600, res = 150)
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(fitted(m2), resid(m2), pch = 16, cex = 0.4, col = rgb(0, 0, 0, 0.25), xlab = "fitted v42", ylab = "residual", main = "M2: residuals vs fitted")
abline(h = 0, col = "firebrick")
qqnorm(resid(m2), pch = 16, cex = 0.4, col = rgb(0, 0, 0, 0.25), main = "M2: normal Q-Q"); qqline(resid(m2), col = "firebrick")
dev.off()

# 6. v42 over time: district mean and interquartile band -----------------------------------------------------
yr <- p[, .(mean = mean(v42), q25 = quantile(v42, .25), q75 = quantile(v42, .75)), by = year]
g <- ggplot(yr, aes(year, mean)) + geom_ribbon(aes(ymin = q25, ymax = q75), fill = "grey80") + geom_line() + geom_point() +
  labs(y = "v42, % of infant deaths due to LBW", x = NULL, title = "District mean of v42 with interquartile band")
ggsave(file.path(FIGURES_DIR, "v42_by_year.png"), g, width = 6, height = 4, dpi = 150)
cat("figures written\n")
