# Replication of the original README table: Kharif

| term | estimate | std_error | p_value | README_estimate | matches_README |
|---|---|---|---|---|---|
| (Intercept) | -4.6131 | 35.4825 | 0.896569 | -4.6131 | yes |
| v12 | -0.00682103 | 0.00833585 | 0.413283 | -0.006821 | yes |
| v15 | 0.0853191 | 0.0493094 | 0.0837124 | 0.085319 | yes |
| v16 | -0.0889488 | 0.0564854 | 0.115456 | -0.088949 | yes |
| v25 | -0.94638 | 0.325936 | 0.00372378 | -0.94638 | yes |
| v28 | 0.0568078 | 0.0254723 | 0.0258299 | 0.056808 | yes |
| female_pct | 0.26683 | 0.241023 | 0.268377 | 0.26683 | yes |
| log(gdp) | 8.47688 | 0.68171 | 2.01946e-34 | 8.47688 | yes |
| log(beds) | -3.85307 | 0.666507 | 8.41692e-09 | -3.85307 | yes |
| log(tap) | 0.084959 | 0.155302 | 0.584393 | 0.084959 | yes |
| cash_index | -0.200288 | 0.0232752 | 1.37327e-17 | -0.200288 | yes |
| cereal_index | -0.960962 | 0.220255 | 1.33886e-05 | -0.960962 | yes |
| child_marriage | -0.0799275 | 0.0185835 | 1.7702e-05 | -0.079927 | yes |
| nitrate | 0.0838986 | 0.0571161 | 0.141991 | 0.083899 | yes |

N = 2354 (README: 2354); adjusted R^2 = 0.2135 (README: 0.2135).

Construction (legacy `Code/Regression/q1a.r`): first crop row per district-year kept by `!duplicated(sdyid)`;
v42 trimmed above mean + 3 sd; listwise deletion on gdp, beds, tap, child_marriage, nitrate; `log()` is the natural log.
Crop category of the row that was kept: Cash 1576, Cereal 772, Horticulture 3, Pulse 2, Coarse Cereal 1.
Rows with cash_index > 0: 66.6%; cereal_index > 0: 32.8%; both zero: 0.6%.
States retained: 24 of 33.

The committed `q1a.r` uses `tap` in levels for Kharif (log for Rabi). With `tap` in levels the Kharif model gives
intercept -0.203159, tap 0.016757 (p = 0.146), adjusted R^2 0.2141, which does not match the README; the README table
was produced with `log(tap)` for both seasons.
