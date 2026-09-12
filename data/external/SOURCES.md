# External data sources

All files retrieved on 2026-09-12. Each is a mirror of a public Government of India release; the mirror,
its license, and the checksum of the file as committed are recorded so the join can be audited.

| File | What | Origin / mirror | Mirror license | Rows | MD5 (as committed) |
|---|---|---|---|---:|---|
| `district-lgd-codes.csv` | LGD district codes with Census 2001/2011 district codes and state codes | India Data Portal (CKAN) resource `19df978a-…`, from lgdirectory.gov.in | Not stated on the resource page; underlying LGD data is Government of India open data | 765 | 93cad1416e901afc76937a430800cfb4 |
| `pca-total.csv` | Census 2011 Primary Census Abstract, district totals (all-India) | github.com/pigshell/india-census-2011 (scraped from censusindia.gov.in) | MIT (mirror); Census data © Office of the Registrar General, India | 640 | 1ebbd3e34237af26da5dc08a4e440464 |
| `pca-full.csv` | Same, with Total/Rural/Urban rows | same | MIT | 1,920 | a356032a0d48917a95196a94d4a2e9b5 |
| `pca-colnames.csv` | Column-name lookup for the PCA files | same | MIT | 87 | 37e533b5cd52db8d37a3d286eef4518c |
| `nfhs4_district-wise.csv` | NFHS-4 (2015-16) district fact sheets, 93 indicators, long format | github.com/HindustanTimesLabs/nfhs-data `nfhs_district-wise.csv` (from rchiips.org/nfhs) | MIT (mirror); survey data © IIPS/MoHFW | 59,240 | original download cb926c495830b4b869930e878b4c5e80; committed copy has CR line endings converted to LF, cp1252 encoding kept |
| `nfhs_indicator_lookup.csv` | Indicator number → description | same | MIT | 93 | 351595cb0b3f7c0825672003f2d4aedd |
| `imd_subdivision_rainfall_1901_2017.csv` | IMD monthly/seasonal rainfall by meteorological sub-division, 1901-2017 | github.com/dcsavinod/weather-and-rainfall-data-from-1901-to-2022 `Rainfall_State_Analysis_India_1901_2017.csv` (from data.gov.in "Sub Divisional Monthly Rainfall from 1901 to 2017") | No license file on mirror; source is data.gov.in (GODL-India) | 4,187 | cc7da67d7f19bf8a7a5182d2b40f55dd |
| `subdivision_to_state.csv` | Hand-written mapping of the 36 IMD sub-divisions to the 33 states/UTs in the dataset | this repository | GPL-3.0-or-later | 44 | — |

Notes
- Telangana was carved out of Andhra Pradesh in 2014. Census 2011 lists its districts under state code 28
  (district codes 532-541); the NFHS-4 mirror does the same. The join scripts handle this explicitly.
- 79 districts in the crop/health data were created after Census 2011 and have Census district code 0 in
  the LGD file; they receive NA for Census and NFHS variables (see `outputs/tables/join_report.md`).
- Puducherry is mapped to the Tamil Nadu sub-division (its main enclave); Mahe and Yanam are ignored.
- States spanning several sub-divisions use the unweighted mean of those sub-divisions.
- Data on GDP, beds, tap water, child marriage and nitrate were collected by the original authors; see the
  README for their sources.
