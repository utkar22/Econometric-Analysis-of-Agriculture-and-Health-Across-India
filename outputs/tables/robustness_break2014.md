# Structural break at 2014: M2 with every regressor interacted with post2014 (year FE absorb the level shift)

| term | label | interaction_estimate | std_error | p_value |
|---|---|---|---|---|
| v12 | v12 discharged <48h (%) | 0.004165 | 0.02296 | 0.8572 |
| v15 | v15 institutional deliveries (%) | 0.001393 | 0.04847 | 0.9773 |
| v25 | v25 live births (%) | 0.572 | 0.6346 | 0.3746 |
| v28 | v28 newborns <2.5 kg (%) | -0.06307 | 0.04414 | 0.1634 |
| female_pct | Female share of births (%) | -1.054 | 0.4005 | 0.01328 |
| log_gdp_pc | log state GDP per capita | -6.791 | 1.542 | 0.0001243 |
| beds_per_lakh | State beds per 100k | 0.004101 | 0.005593 | 0.469 |
| log_tap | log tap-water HH (%) | 0.3049 | 0.2981 | 0.3146 |
| child_marriage_per_mn | Child-marriage cases per mn | 6.934 | 2.939 | 0.02501 |
| yi_kharif_cash_0 | Kharif cash-crop yield index | -0.01847 | 0.02186 | 0.4048 |
| grows_kharif_cash | Grows kharif cash crops (1/0) | 0.1546 | 1.017 | 0.8802 |
| yi_kharif_cereal_0 | Kharif cereal yield index | 0.2644 | 0.4139 | 0.5278 |
| grows_kharif_cereal | Grows kharif cereals (1/0) | -1.273 | 1.625 | 0.4395 |
| yi_rabi_cash_0 | Rabi cash-crop yield index | -0.08623 | 0.019 | 8.528e-05 |
| grows_rabi_cash | Grows rabi cash crops (1/0) | 0.238 | 1.082 | 0.8274 |
| yi_rabi_cereal_0 | Rabi cereal yield index | -0.04152 | 0.3648 | 0.9101 |
| grows_rabi_cereal | Grows rabi cereals (1/0) | -8.825 | 2.297 | 0.0005892 |

Joint Wald test that all interactions are zero: F = 50.452, p = 0.0000 (clustered by state).
Replaces legacy before_after.r, which fitted separate bivariate regressions before and after 2014.
