# SPDX-License-Identifier: GPL-3.0-or-later
# Installs the R packages used by the analysis scripts in R/.
pkgs <- c("data.table", "fixest", "sandwich", "lmtest", "car", "ggplot2", "modelsummary", "jsonlite")
missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) {
  install.packages(missing, repos = "https://cloud.r-project.org")
} else {
  message("All packages already installed.")
}
