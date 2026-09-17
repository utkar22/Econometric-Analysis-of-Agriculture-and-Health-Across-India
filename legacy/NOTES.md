# Legacy scripts

This folder holds the coursework scripts exactly as written for the two data assignments and the final
project (Econometrics, 2023), with the minimum edits needed to run them from the repository root. They are
kept because the README tables and the two PDF reports in `Reports/` were produced with them. The analysis
that supersedes them lives in `src/prep/` and `R/`; its review of these scripts is in `docs/REVIEW.md`.

## Running

From the repository root, e.g. `Rscript legacy/Code/Regression/q1a.r`. Every R script reads
`data/raw/main_final.csv` (the original `main9.csv` / `main_final.csv`; identical columns in the positions the
scripts use). Plot scripts write to `Rplots.pdf` when run non-interactively (git-ignored). `monte_carlo.R` runs 1000 iterations of a row-by-row `append()` loop and takes about two minutes; it is otherwise unchanged.

The Python cleaners in `Code/Data Cleaning/` cannot run: their inputs (`main.csv`, `mains.csv`, `main10.csv`,
`flourine.csv`) were never committed. They document how `gdp`, `beds`, `tap`, `child_marriage` and `nitrate`
were attached to the source file (state/district name matching, positional column indexing).

## Map: assignment question → script → report

| Report | Question | Script | Output |
|---|---|---|---|
| `Reports/Prelim Report 1.pdf` (Data Assignment 1) | Q2a descriptive statistics | `Code/central_tendency.r` | mean/median/mode/sd of v40–v46 |
| | Q2b histograms by year / season | `Code/Graphs/Q2B4*Y.R`, `Q2B4*S.R`, `q2b.R` | `Outputs/Histogram/*.png` |
| | Q2d correlations | `Code/Correlation Analysis/q2d1.r`, `q2d2.R`, `q2d3.R` | correlation tables |
| | Q3a–g fever regressions | `Code/Regression/q3a.R` … `q3g.R` | `Outputs/Regression/mod-*.png` |
| Data Assignment 2 / `Reports/Project.pdf` | Q1a main LBW model, Kharif and Rabi | `Code/Regression/q1a.r` | README tables (see note below) |
| | Q1b–d residual plots | `Code/Graphs/q1bcd.R` | |
| | zone dummies and ANOVA | `Code/ANOVA.R` | |
| | before/after 2014 | `Code/Correlation Analysis/before_after.r` | |
| | Monte Carlo subsampling | `Code/monte_carlo.R` | |
| | v42 by year | `Code/Graphs/data_year_graph.r` | |

## Edits made here (nothing else was changed)

- Removed the Windows `setwd(...)` lines; all `read.csv()` calls point at `data/raw/main_final.csv`.
- `monte_carlo.R`: `!duplicated(datafile$sdyid)` → `!duplicated(data_kharif$sdyid)` / `data_rabi` (the original
  indexed a subset with a logical vector of the full file's length).
- `ANOVA.R`: the Rabi loop read `state` from the Kharif data; "Orissa" → "Odisha", "Kerela" → "Kerala".
  Jammu and Kashmir, Delhi, Chandigarh, Puducherry and Andaman & Nicobar are still in no zone, as originally.
- `Graphs/q1bcd.R`: defined `clean_data_kharif`/`clean_data_rabi` (as in `q1a.r`), fixed the two `df_b_i`
  references, dropped the unused `tidyverse` import.
- `Graphs/Q2B43S.R`: removed a trailing `plot()`. `central_tendency.r`: removed a stray `group` argument.
- Deleted five one-off probes: `no_of_lines.py`, `csv_cleaner.py`, `checker.py`, `for_seasons.py`, `for_yi.py`.

## Known flaws left in place

`q1a.r` keeps the first crop row per district-year and derives `cash_index`/`cereal_index` from that row's
category (an artefact of row order); the Kharif model uses `tap` in levels although the README table was produced
with `log(tap)`; standard errors are iid; nitrate listwise deletion drops nine states; growth-rate scripts rely on
row adjacency. Details and numbers: `docs/REVIEW.md`.
