# SPDX-License-Identifier: GPL-3.0-or-later
# Reproduce the two regression tables in the original README from the raw file, using the legacy
# construction exactly (Code/Regression/q1a.r): subset a season, keep the first crop row per district-year,
# drop v42 above mean+3sd, listwise-delete on gdp/beds/tap/child_marriage/nitrate, define cash_index /
# cereal_index from that first row's crop category, OLS with log(gdp), log(beds), log(tap).
# The script asserts that the numbers equal the README tables to 6 decimals; it also reports what the
# committed q1a.r produces for Kharif (tap in levels), which is what the repository code actually ran.
source("R/00_setup.R")

raw <- fread(RAW_PATH)

legacy_sample <- function(season_name) {
  s <- raw[season == season_name]
  s <- s[!duplicated(sdyid)]                                  # first crop row per district-year
  ub <- mean(s$v42) + 3 * sd(s$v42)
  s[, female_pct := v31 / (1000 + v31) * 100]
  s <- s[v42 < ub & !is.na(gdp) & !is.na(beds) & !is.na(tap) & gdp != 0 & beds != 0 & tap != 0 &
         !is.na(child_marriage) & !is.na(nitrate)]
  s[, cash_index := ifelse(cropcategory == "Cash", index, 0)]
  s[, cereal_index := ifelse(cropcategory == "Cereal", index, 0)]
  s
}

fit_legacy <- function(s, log_tap = TRUE) {
  f <- if (log_tap) {
    v42 ~ v12 + v15 + v16 + v25 + v28 + female_pct + log(gdp) + log(beds) + log(tap) + cash_index + cereal_index + child_marriage + nitrate
  } else {
    v42 ~ v12 + v15 + v16 + v25 + v28 + female_pct + log(gdp) + log(beds) + tap + cash_index + cereal_index + child_marriage + nitrate
  }
  lm(f, data = s)
}

README <- list(
  Kharif = c(-4.613096, -0.006821, 0.085319, -0.088949, -0.946380, 0.056808, 0.266830, 8.476883, -3.853067,
             0.084959, -0.200288, -0.960962, -0.079927, 0.083899),
  Rabi   = c(26.982771, -0.020824, 0.158064, -0.146382, -1.201496, 0.084825, 0.270657, 8.545709, -4.859878,
             0.693176, 0.031997, -0.710848, -0.041665, 0.060745)
)
README_N <- c(Kharif = 2354, Rabi = 2355)
README_ADJR2 <- c(Kharif = 0.2135, Rabi = 0.195)

for (season in c("Kharif", "Rabi")) {
  s <- legacy_sample(season)
  m <- fit_legacy(s, log_tap = TRUE)
  ct <- summary(m)$coefficients
  est <- unname(ct[, 1])
  ok <- abs(round(est, 6) - README[[season]]) <= 1e-6
  adj <- summary(m)$adj.r.squared
  stopifnot(nobs(m) == README_N[[season]])
  stopifnot(abs(round(adj, 4) - README_ADJR2[[season]]) < 1e-3)
  stopifnot(all(ok))

  share_cash <- mean(s$cash_index > 0); share_cereal <- mean(s$cereal_index > 0)
  first_cat <- s[, .N, by = cropcategory][order(-N)]
  tab <- data.frame(term = rownames(ct), estimate = est, std_error = ct[, 2], p_value = ct[, 4],
                    README_estimate = README[[season]], matches_README = ifelse(ok, "yes", "no"))
  notes <- c(
    sprintf("N = %d (README: %d); adjusted R^2 = %.4f (README: %.4f).", nobs(m), README_N[[season]], adj, README_ADJR2[[season]]),
    "",
    "Construction (legacy `Code/Regression/q1a.r`): first crop row per district-year kept by `!duplicated(sdyid)`;",
    "v42 trimmed above mean + 3 sd; listwise deletion on gdp, beds, tap, child_marriage, nitrate; `log()` is the natural log.",
    sprintf("Crop category of the row that was kept: %s.", paste(sprintf("%s %d", first_cat$cropcategory, first_cat$N), collapse = ", ")),
    sprintf("Rows with cash_index > 0: %.1f%%; cereal_index > 0: %.1f%%; both zero: %.1f%%.", 100 * share_cash, 100 * share_cereal,
            100 * mean(s$cash_index == 0 & s$cereal_index == 0)),
    sprintf("States retained: %d of %d.", uniqueN(s$state), uniqueN(raw$state))
  )
  if (season == "Kharif") {
    m_lvl <- fit_legacy(s, log_tap = FALSE)
    ct2 <- summary(m_lvl)$coefficients
    notes <- c(notes, "",
               "The committed `q1a.r` uses `tap` in levels for Kharif (log for Rabi). With `tap` in levels the Kharif model gives",
               sprintf("intercept %.6f, tap %.6f (p = %.3f), adjusted R^2 %.4f, which does not match the README; the README table",
                       ct2[1, 1], ct2["tap", 1], ct2["tap", 4], summary(m_lvl)$adj.r.squared),
               "was produced with `log(tap)` for both seasons.")
  }
  write_md_table(tab, file.path(TABLES_DIR, sprintf("replication_%s.md", tolower(season))), digits = 6,
                 title = sprintf("Replication of the original README table: %s", season), notes = notes)
  cat(sprintf("%s: replicated README table (N=%d, adj R2=%.4f), all 14 coefficients match to 6 dp\n", season, nobs(m), adj))
}
