# Review of the original analysis

Scope: everything in the repository as of commit `e33ca66` (August 2023): the data-cleaning Python scripts,
the assignment R scripts, the two README regression tables and the narrative findings. Every claim below was
checked by re-running the original construction on `Datasets/main_final.csv` (now `data/raw/main_final.csv`);
`R/02_replicate_original.R` reproduces the README tables and asserts the match.

## 1. What reproduces

| Table | Reproduces? | Detail |
|---|---|---|
| README Rabi model | Yes, to 6 decimals | N = 2355, adjusted R² = 0.195 |
| README Kharif model | Yes, to 6 decimals, but only with `log(tap)` | The committed `q1a.r` uses `tap` in levels for Kharif; that gives intercept −0.203 and tap 0.017 (p = 0.146), not the README's −4.613 / 0.085. The README table was made with `log(tap)` for both seasons. |
| README says `log10` | No | Every script uses the natural log. Slopes on GDP, beds and tap in the tables are per unit of ln(x). |

## 2. Methodological problems, in order of importance

1. **The crop indices are an artefact of row order.** `clean_data_kharif <- data_kharif[!duplicated(data_kharif$sdyid),]`
   keeps the first crop row of each district-year in whatever order the CSV happens to have. That row's crop
   category then decides which of `cash_index` and `cereal_index` is non-zero. In the Kharif sample the kept row is
   Cash for 1576 district-years and Cereal for 772 (Horticulture 3, Pulse 2, Coarse Cereal 1); in Rabi it is Cereal
   for 65% and Cash for 31%. So `cash_index` is "the yield of the first row, if that row was a cash crop, else 0"; it
   is not the district's cash-crop yield. With the indices built per category (`yi_kharif_cash` etc. in
   `data/processed/panel.csv`), the Kharif cash-crop coefficient goes from −0.200*** to −0.175*** in the same
   sample with state-clustered SEs, then to −0.079 (n.s.) once the nitrate-driven sample restriction is lifted.
2. **The Kharif and Rabi models are not two samples.** `v42` and all v-variables are annual and constant within a
   district-year (verified: 0 district-years with more than one v42 value); 3,524 district-years appear in both
   seasonal samples. The two README tables regress the same outcome on the same regressors and differ only in
   which crop row was picked. Anything described as a seasonal difference is a difference in that pick.
3. **No clustering, no fixed effects.** `gdp`, `beds`, `child_marriage` and `nitrate` vary only by state (or
   state-year) while observations are district-years; the tables use iid standard errors on 24 states. With
   state-clustered SEs the child-marriage coefficient in the original-style model is −0.014 (p = 0.83) instead of
   −0.080 (p < 0.001), and log beds is −2.77 (p = 0.13) instead of −3.85 (p < 1e-8). The panel structure
   (6 years × 673 districts) was never used.
4. **Heteroskedasticity and non-normal residuals** (Breusch–Pagan p ≈ 1e-10; Jarque–Bera p ≈ 1e-44) with no
   robust SEs. The report notes that weighting was attempted and abandoned.
5. **Multicollinearity.** `v15`/`v16` correlate at 0.94 (VIF ≈ 10); `log(gdp)`/`log(beds)` at 0.93 (VIF ≈ 11–13).
   The opposite signs on v15 and v16, and on GDP and beds, are what collinear pairs produce; they are not
   separately interpretable.
6. **Nitrate missingness drives the sample.** Nitrate is missing for 32% of rows and for nine states entirely
   (Chhattisgarh, Telangana, Uttarakhand, Sikkim, Andaman & Nicobar, Chandigarh, Puducherry, Arunachal Pradesh,
   most of Delhi). Listwise deletion drops them all, so the README models cover 24 of 33 states. Nitrate itself
   is never significant.
7. **Bounded share modelled as linear, one-sided trimming.** `v42` is a percentage with 13% exact zeros and 0.3%
   at 100; the models are linear OLS after dropping values above mean + 3 sd (≈ 60) but never values at 0.
8. **Level variables that should be rates.** `child_marriage` is the state's count of reported cases (a reporting
   artefact more than a prevalence measure), `gdp` and `beds` are state totals. None is per capita; `beds` is a
   single-year figure repeated across years, so it is collinear with any state effect.
9. **Growth-rate scripts depend on row adjacency and district names.** `q3d.R`, `q3e.R` and `q2d3.R` compute
   growth as row *i* minus row *i−1*, matching on district name only. Four names exist in two states (Aurangabad,
   Balrampur, Bilaspur, Pratapgarh) and `q3d`/`q3e` do not check the season (19 cross-season pairs).
10. **"Monte Carlo" is subsampling without intervals.** `monte_carlo.R` drops 20% of rows at random and compares
    the mean coefficient with the full-sample one; it says nothing about sampling variability.
11. **The 2014 child-marriage "drop" is not in the data.** Summing the state counts by year gives
    214, 304, 240, 277, 298, 321 for 2011–2016: the low year after 2012 is 2013, and 2014 is higher than 2013.

## 3. Bugs in the committed scripts

| File | Line | Problem | Fixed in `legacy/`? |
|---|---|---|---|
| `Code/monte_carlo.R` | 372–373 | `data_kharif[!duplicated(datafile$sdyid),]`: a logical vector of the wrong length, so rows are recycled | yes |
| `Code/ANOVA.R` | 196 | Rabi loop reads `state` from `clean_data_kharif` | yes |
| `Code/ANOVA.R` | 19–24 | Zones spell "Orissa" and "Kerela"; Jammu and Kashmir, Delhi, Chandigarh, Puducherry, Andaman & Nicobar belong to no zone (304 retained Kharif rows) | spelling yes; unassigned states left as documented |
| `Code/Graphs/q1bcd.R` | 27, 60, 63 | Uses `clean_data_kharif`, `clean_data_rabi`, `df_b_i`, none defined; loads `tidyverse` which it does not use | yes |
| `Code/Graphs/Q2B43S.R` | 15 | Trailing `plot()` with no arguments | yes |
| `Code/central_tendency.r` | 637 | `mean(datafile$v40, na.rm = TRUE, group)`: `group` is undefined | yes |
| every R script | top | `setwd("C:\\Users\\Utkarsh\\...")` and `read.csv("main9.csv")`; `main9.csv` is not in the repository (`main_cleaned.csv` was its equivalent) | yes, all read `data/raw/main_final.csv` from the repository root |
| `Code/Data Cleaning/*.py` | — | Read `main.csv`, `mains.csv`, `main10.csv`, `flourine.csv`, none in the repository; address columns by position | not runnable; kept for the record |

## 4. Dead or redundant material

- `no_of_lines.py`, `csv_cleaner.py`, `checker.py`, `for_seasons.py`, `for_yi.py`: one-off probes (deleted).
- `Datasets/main_cleaned.csv` was `main_final.csv` without the two last columns, identical otherwise (deleted).
- Columns `country`, `_merge` (all `matched (3)`), `v48` (all `No`) are constant (dropped in processing).
- `Outputs/*.png` were screenshots of R console output (kept under `legacy/Outputs`, superseded by `outputs/`).
- Twelve near-identical histogram scripts (`Q2B4xS.R`, `Q2B4xY.R`) are one faceted figure now.

## 5. What the corrected analysis shows

See `outputs/tables/main_models.md` and the README. In short: with correctly built crop indices and
state-clustered SEs, the cross-sectional associations that survive are state GDP per capita (positive: richer
states report a larger LBW share of infant deaths, most plausibly a reporting/cause-attribution pattern) and the
rabi cereal yield index (negative). Once district fixed effects absorb everything that does not change within a
district, no time-varying regressor, yield shocks and monsoon anomalies included, explains within-district
changes in `v42` (within-R² < 0.01). The original report's headline effects of child marriage, hospital beds and
the Kharif cash-crop index were products of the index construction and of iid standard errors on state-level
regressors.
