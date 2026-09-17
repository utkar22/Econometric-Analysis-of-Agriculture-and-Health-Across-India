# District cluster bootstrap (999 resamples of districts with replacement): percentile 95% CIs vs state-clustered SEs

| model | term | label | estimate | boot_se | boot_ci_low | boot_ci_high | cluster_state_se | excludes_zero |
|---|---|---|---|---|---|---|---|---|
| M2 | beds_per_lakh | State beds per 100k | -0.01336 | 0.005566 | -0.02405 | -0.002907 | 0.01252 | yes |
| M2 | child_marriage_per_mn | Child-marriage cases per mn | 1.088 | 1.225 | -0.8908 |   3.9 | 1.701 | no |
| M2 | female_pct | Female share of births (%) | 0.006211 | 0.2438 | -0.4715 | 0.4585 | 0.2821 | no |
| M2 | grows_kharif_cash | Grows kharif cash crops (1/0) | 1.243 | 0.6804 | -0.1838 | 2.422 | 0.744 | no |
| M2 | grows_kharif_cereal | Grows kharif cereals (1/0) | 1.256 | 1.644 | -1.75 | 4.668 | 1.381 | no |
| M2 | grows_rabi_cash | Grows rabi cash crops (1/0) | 0.9316 | 0.6634 | -0.3496 | 2.241 | 0.8459 | no |
| M2 | grows_rabi_cereal | Grows rabi cereals (1/0) | 6.939 |  1.43 | 4.237 | 9.864 | 1.676 | yes |
| M2 | log_gdp_pc | log state GDP per capita | 6.541 |   1.3 | 3.962 | 9.036 | 2.638 | yes |
| M2 | log_tap | log tap-water HH (%) | 0.2464 | 0.2321 | -0.1882 | 0.7049 | 0.2602 | no |
| M2 | v12 | v12 discharged <48h (%) | 0.001762 | 0.01079 | -0.01859 | 0.02302 | 0.01396 | no |
| M2 | v15 | v15 institutional deliveries (%) | 0.06864 | 0.02171 | 0.02547 | 0.1087 | 0.02427 | yes |
| M2 | v25 | v25 live births (%) | -0.5947 | 0.3643 | -1.367 | 0.08232 | 0.4024 | no |
| M2 | v28 | v28 newborns <2.5 kg (%) | 0.03178 | 0.03097 | -0.02865 | 0.09193 | 0.04419 | no |
| M2 | yi_kharif_cash_0 | Kharif cash-crop yield index | 0.04497 | 0.02375 | 0.00593 | 0.09931 | 0.0344 | yes |
| M2 | yi_kharif_cereal_0 | Kharif cereal yield index | -0.05291 | 0.3107 | -0.6333 | 0.5296 | 0.3871 | no |
| M2 | yi_rabi_cash_0 | Rabi cash-crop yield index | 0.06055 | 0.02013 | 0.02005 | 0.09818 | 0.02342 | yes |
| M2 | yi_rabi_cereal_0 | Rabi cereal yield index | -1.461 | 0.2399 | -1.945 | -0.9946 | 0.2942 | yes |
| M3 | child_marriage_per_mn | Child-marriage cases per mn | 2.059 | 1.145 | 0.07767 | 4.565 |  1.15 | yes |
| M3 | female_pct | Female share of births (%) | -0.234 | 0.3012 | -0.8157 | 0.3956 | 0.3772 | no |
| M3 | log_gdp_pc | log state GDP per capita | -1.473 | 5.451 | -12.09 | 8.948 | 6.792 | no |
| M3 | rain_jjas_anom | Monsoon rainfall anomaly (z) | 0.1745 | 0.2442 | -0.282 | 0.6855 | 0.334 | no |
| M3 | v12 | v12 discharged <48h (%) | 0.01922 | 0.01321 | -0.008573 | 0.04427 | 0.02396 | no |
| M3 | v15 | v15 institutional deliveries (%) | -0.06289 | 0.04165 | -0.1497 | 0.01555 | 0.06358 | no |
| M3 | v25 | v25 live births (%) | 0.8417 | 0.4654 | -0.04235 | 1.779 | 0.6088 | no |
| M3 | v28 | v28 newborns <2.5 kg (%) | 0.05181 | 0.03528 | -0.01504 | 0.1249 | 0.06169 | no |
| M3 | yidev_kharif_all | Kharif yield shock (log dev.) | 0.4352 | 0.8151 | -0.9217 | 2.166 | 0.8636 | no |
| M3 | yidev_rabi_all | Rabi yield shock (log dev.) | -0.5666 | 0.8052 | -2.305 | 0.9331 | 0.491 | no |

The 671 districts in the trimmed sample are resampled with replacement (999 draws); in M3 each drawn copy gets its own fixed effect.
This replaces the legacy monte_carlo.R, which dropped 20% of rows at random and compared mean coefficients without intervals.
