# Fractional logit (Papke-Wooldridge) for M2, outcome v42/100, year + zone FE, SEs clustered by state

| term | label | logit_coef | logit_se | logit_p | AME_pct_points | OLS_M2 | OLS_p |
|---|---|---|---|---|---|---|---|
| v12 | v12 discharged <48h (%) | 0.0001243 | 0.0009994 | 0.901 | 0.001735 | 0.001762 | 0.9004 |
| v15 | v15 institutional deliveries (%) | 0.006127 | 0.002312 | 0.00806 | 0.08548 | 0.06864 | 0.00825 |
| v25 | v25 live births (%) | -0.04974 | 0.03268 | 0.1279 | -0.694 | -0.5947 | 0.1499 |
| v28 | v28 newborns <2.5 kg (%) | 0.003274 | 0.003042 | 0.2817 | 0.04568 | 0.03178 | 0.4776 |
| female_pct | Female share of births (%) | 0.0003881 | 0.02205 | 0.986 | 0.005414 | 0.006211 | 0.9826 |
| log_gdp_pc | log state GDP per capita | 0.4779 | 0.1789 | 0.007553 | 6.668 | 6.541 | 0.019 |
| beds_per_lakh | State beds per 100k | -0.001018 | 0.0009186 | 0.2676 | -0.01421 | -0.01336 | 0.2946 |
| log_tap | log tap-water HH (%) | 0.01782 | 0.02033 | 0.3807 | 0.2486 | 0.2464 | 0.3512 |
| child_marriage_per_mn | Child-marriage cases per mn | 0.09506 | 0.1241 | 0.4437 | 1.326 | 1.088 | 0.5271 |
| yi_kharif_cash_0 | Kharif cash-crop yield index | 0.001841 | 0.001999 | 0.357 | 0.02569 | 0.04497 | 0.2011 |
| grows_kharif_cash | Grows kharif cash crops (1/0) | 0.08831 | 0.05626 | 0.1165 | 1.232 | 1.243 | 0.1052 |
| yi_kharif_cereal_0 | Kharif cereal yield index | -0.003498 | 0.0261 | 0.8934 | -0.04881 | -0.05291 | 0.8922 |
| grows_kharif_cereal | Grows kharif cereals (1/0) | 0.07592 | 0.08198 | 0.3544 | 1.059 | 1.256 | 0.3705 |
| yi_rabi_cash_0 | Rabi cash-crop yield index | 0.003404 | 0.001579 | 0.03104 | 0.0475 | 0.06055 | 0.01484 |
| grows_rabi_cash | Grows rabi cash crops (1/0) | 0.03275 | 0.0527 | 0.5342 | 0.457 | 0.9316 | 0.2795 |
| yi_rabi_cereal_0 | Rabi cereal yield index | -0.1026 | 0.01959 | 1.637e-07 | -1.432 | -1.461 | 2.57e-05 |
| grows_rabi_cereal | Grows rabi cereals (1/0) | 0.5328 | 0.1465 | 0.0002757 | 7.433 | 6.939 | 0.0002599 |

N = 3478. AME = logit coefficient x mean(dP/deta) x 100, comparable to the OLS column (percentage points of v42).
A logit link keeps predictions inside [0, 100]; OLS does not. Agreement in sign and rough magnitude means the linear model is not misleading.
