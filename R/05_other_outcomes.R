# SPDX-License-Identifier: GPL-3.0-or-later
# The M2 and M3 specifications applied to every cause-of-death share in the data
# (sepsis, LBW, pneumonia, diarrhoea, fever, measles). No trimming here so the six outcomes are treated alike;
# the shares are heavily zero-inflated for diarrhoea, fever and measles (see descriptives.md).
source("R/00_setup.R")
suppressPackageStartupMessages({ library(fixest); library(modelsummary) })

p <- build_model_data(load_panel())
for (spec in c("m2", "m3")) {
  ms <- list()
  for (o in names(OUTCOMES)) {
    ms[[sprintf("%s (%s)", OUTCOMES[o], o)]] <- feols(spec_formula(o, spec), data = p, cluster = ~state)
  }
  write_models_md(ms, output = file.path(TABLES_DIR, sprintf("other_outcomes_%s.md", spec)), coef_map = COEF_MAP, gof_map = GOF_MAP, stars = STARS,
               title = sprintf("%s applied to each cause-of-death share (%% of reported infant deaths), no trimming, SEs clustered by state",
                               SPEC_NAMES[spec]),
               notes = "Zero shares: diarrhoea 56%, fever 37%, measles 92% of district-years; treat those columns as descriptive only.")
  tidy <- rbindlist(lapply(names(ms), function(nm) as.data.table(tidy_fixest(ms[[nm]]))[, outcome := nm][, spec := spec]))
  fwrite(tidy, file.path(TABLES_DIR, sprintf("other_outcomes_%s_tidy.csv", spec)))
}
cat("other-outcome tables written\n")
