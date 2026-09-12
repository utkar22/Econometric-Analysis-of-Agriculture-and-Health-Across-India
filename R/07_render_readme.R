# SPDX-License-Identifier: GPL-3.0-or-later
# Splices generated tables into README.md between marker comments:
#   <!-- BEGIN TABLE: outputs/tables/xxx.md -->  ...  <!-- END TABLE -->
# The first line of each table file (its "# title") is dropped; everything else is copied verbatim.
readme <- readLines("README.md")
out <- character(0); i <- 1
while (i <= length(readme)) {
  line <- readme[i]
  m <- regmatches(line, regexec("^<!-- BEGIN TABLE: (\\S+) -->\\s*$", line))[[1]]
  if (length(m) == 2) {
    out <- c(out, line)
    body <- readLines(m[2])
    body <- body[-1]
    while (length(body) && body[1] == "") body <- body[-1]
    out <- c(out, body)
    j <- i + 1
    while (j <= length(readme) && !grepl("^<!-- END TABLE -->", readme[j])) j <- j + 1
    if (j > length(readme)) stop("missing END TABLE marker after ", m[2])
    out <- c(out, readme[j]); i <- j + 1
  } else {
    out <- c(out, line); i <- i + 1
  }
}
writeLines(out, "README.md")
cat("README tables refreshed\n")
