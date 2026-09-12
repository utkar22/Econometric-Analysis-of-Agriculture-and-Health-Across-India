# M1: same point estimates, three standard-error treatments

| term | estimate | std_error_iid | p_value_iid | std_error_HC1 | p_value_HC1 | std_error_cluster_state | p_value_cluster_state | label |
|---|---|---|---|---|---|---|---|---|
| (Intercept) | -22.19 | 34.78 | 0.5235 | 38.03 | 0.5597 | 57.77 | 0.7044 | (Intercept) |
| child_marriage | -0.01404 | 0.02043 | 0.4921 | 0.02378 | 0.555 | 0.06509 | 0.8311 | Child-marriage cases (state count) |
| female_pct | 0.2158 | 0.2373 | 0.3633 | 0.251 | 0.3899 |  0.42 | 0.6123 | Female share of births (%) |
| grows_kharif_cash | 1.333 | 0.5436 | 0.01428 | 0.5616 | 0.01768 | 1.049 | 0.2164 | Grows kharif cash crops (1/0) |
| grows_kharif_cereal | 1.467 | 1.263 | 0.2454 |  1.21 | 0.2256 | 1.421 | 0.3126 | Grows kharif cereals (1/0) |
| grows_rabi_cash | -0.4672 | 0.6027 | 0.4383 | 0.6413 | 0.4663 | 0.947 | 0.6264 | Grows rabi cash crops (1/0) |
| grows_rabi_cereal | 9.592 | 1.349 | 1.535e-12 | 1.408 | 1.223e-11 | 1.759 | 1.523e-05 | Grows rabi cereals (1/0) |
| log_beds | -2.771 | 0.6919 | 6.398e-05 | 0.6927 | 6.534e-05 | 1.789 | 0.1351 | log state beds |
| log_gdp |   7.3 | 0.7194 | 1.034e-23 | 0.6936 | 2.411e-25 | 1.815 | 0.0005341 | log state GDP |
| log_tap | 0.4411 | 0.1602 | 0.005962 | 0.1675 | 0.00852 | 0.2932 | 0.1462 | log tap-water HH (%) |
| nitrate | 0.1322 | 0.05948 | 0.02633 | 0.07124 | 0.06361 | 0.1197 | 0.2809 | Nitrate (state) |
| v12 | 0.002252 | 0.008437 | 0.7896 | 0.008516 | 0.7915 | 0.02529 | 0.9298 | v12 discharged <48h (%) |
| v15 | 0.0708 | 0.04859 | 0.1453 | 0.05804 | 0.2227 | 0.06123 | 0.2595 | v15 institutional deliveries (%) |
| v16 | -0.06156 | 0.05526 | 0.2654 | 0.06313 | 0.3296 | 0.08131 | 0.4567 | v16 safe deliveries (%) |
| v25 | -0.7609 | 0.3195 | 0.01732 | 0.3477 | 0.02872 | 0.4644 | 0.1149 | v25 live births (%) |
| v28 | 0.04651 | 0.02512 | 0.06418 | 0.02223 | 0.03653 | 0.03766 | 0.2293 | v28 newborns <2.5 kg (%) |
| yi_kharif_cash_0 | -0.1754 | 0.02302 | 3.73e-14 | 0.02486 | 2.244e-12 | 0.03902 | 0.0001642 | Kharif cash-crop yield index |
| yi_kharif_cereal_0 | -0.4656 | 0.2851 | 0.1027 | 0.3277 | 0.1555 | 0.4478 | 0.3093 | Kharif cereal yield index |
| yi_rabi_cash_0 | 0.05587 | 0.01819 | 0.002157 | 0.01662 | 0.0007866 | 0.02792 | 0.05734 | Rabi cash-crop yield index |
| yi_rabi_cereal_0 | -1.691 | 0.2216 | 3.345e-14 | 0.238 | 1.594e-12 | 0.429 | 0.0006506 | Rabi cereal yield index |

N = 2375; 24 state clusters.
gdp, beds, child_marriage and nitrate vary only at the state(-year) level and the original model's residuals are heteroskedastic,
so the state-clustered column is the one to read.
