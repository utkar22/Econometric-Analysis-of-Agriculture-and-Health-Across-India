# Replication of the original README table: Rabi

| term | estimate | std_error | p_value | README_estimate | matches_README |
|---|---|---|---|---|---|
| (Intercept) | 26.9828 | 35.6985 | 0.449815 | 26.9828 | yes |
| v12 | -0.0208242 | 0.00846475 | 0.0139611 | -0.020824 | yes |
| v15 | 0.158064 | 0.0492164 | 0.00133778 | 0.158064 | yes |
| v16 | -0.146382 | 0.05644 | 0.00955751 | -0.146382 | yes |
| v25 | -1.2015 | 0.327944 | 0.000254101 | -1.2015 | yes |
| v28 | 0.0848248 | 0.0258125 | 0.00103052 | 0.084825 | yes |
| female_pct | 0.270657 | 0.245139 | 0.269665 | 0.270657 | yes |
| log(gdp) | 8.54571 | 0.712186 | 3.09848e-32 | 8.54571 | yes |
| log(beds) | -4.85988 | 0.655047 | 1.64004e-13 | -4.85988 | yes |
| log(tap) | 0.693176 | 0.15125 | 4.82502e-06 | 0.693176 | yes |
| cash_index | 0.031997 | 0.0176042 | 0.0692565 | 0.031997 | yes |
| cereal_index | -0.710848 | 0.180942 | 8.79199e-05 | -0.710848 | yes |
| child_marriage | -0.0416651 | 0.0196956 | 0.0344964 | -0.041665 | yes |
| nitrate | 0.0607449 | 0.0615508 | 0.323791 | 0.060745 | yes |

N = 2355 (README: 2355); adjusted R^2 = 0.1950 (README: 0.1950).

Construction (legacy `Code/Regression/q1a.r`): first crop row per district-year kept by `!duplicated(sdyid)`;
v42 trimmed above mean + 3 sd; listwise deletion on gdp, beds, tap, child_marriage, nitrate; `log()` is the natural log.
Crop category of the row that was kept: Cereal 1540, Cash 742, Pulse 31, Horticulture 19, Coarse Cereal 17, Oilseed 6.
Rows with cash_index > 0: 31.5%; cereal_index > 0: 65.4%; both zero: 3.1%.
States retained: 24 of 33.
