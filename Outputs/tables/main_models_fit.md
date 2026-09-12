# Sample and fit by model

| model | N | states | districts | adj_r2 | within_r2 |
|---|---|---|---|---|---|
| M1 original spec, corrected indices |  2375 |    24 |   565 | 0.2533 |  |
| M1b no nitrate |  3478 |    31 |   659 | 0.2157 |  |
| M2 year+zone FE |  3478 |    31 |   659 | 0.2667 | 0.08308 |
| M3 district+year FE |  3432 |    33 |   635 | 0.453 | 0.007824 |
| M4 M2 + Census/NFHS |  3143 |    31 |   584 | 0.2881 | 0.1209 |
| M5 lags |  2664 |    33 |   612 | 0.4837 | 0.01291 |
