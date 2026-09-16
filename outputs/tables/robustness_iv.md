# Kharif yield shock instrumented by the state monsoon rainfall anomaly (district + year FE, SEs clustered by state)

| estimator | kharif_shock_estimate | std_error | p_value |
|---|---|---|---|
| OLS (M3) | 0.4352 | 0.8636 | 0.6177 |
| 2SLS |  7.29 | 13.31 | 0.5876 |

First stage: rain_jjas_anom coefficient 0.0255 (SE 0.0167); first-stage F = 13.53 (clustered Wald F = 2.31).
Clustered first-stage F below 10: the instrument is weak and the 2SLS estimate is not interpreted.
Rainfall varies at the state-year level (36 IMD sub-divisions averaged to states).
