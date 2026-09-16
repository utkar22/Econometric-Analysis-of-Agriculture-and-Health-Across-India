# External data sources

All files retrieved on 2026-09-12. Each is a mirror of a public Government of India release; the mirror,
its license, and the checksum of the file as committed are recorded so the join can be audited.

| File | What | Origin / mirror | Mirror license | Rows | MD5 (as committed) |
|---|---|---|---|---:|---|
| `district-lgd-codes.csv` | LGD district codes with Census 2001/2011 district codes and state codes | India Data Portal (CKAN) dataset `a7419751-ac37-46ad-b938-638cda7b7b60`, resource `19df978a-675e-4ff5-8015-d0e1de447319`: https://ckandev.indiadataportal.com/dataset/a7419751-ac37-46ad-b938-638cda7b7b60/resource/19df978a-675e-4ff5-8015-d0e1de447319/download/district-lgd-codes.csv (from lgdirectory.gov.in) | Not stated on the resource page; underlying LGD data is Government of India open data | 765 | 93cad1416e901afc76937a430800cfb4 |
| `pca-total.csv` | Census 2011 Primary Census Abstract, district totals (all-India) | https://raw.githubusercontent.com/pigshell/india-census-2011/master/pca-total.csv (github.com/pigshell/india-census-2011, scraped from censusindia.gov.in) | MIT (mirror); Census data © Office of the Registrar General, India | 640 | 1ebbd3e34237af26da5dc08a4e440464 |
| `pca-full.csv` | Same, with Total/Rural/Urban rows | https://raw.githubusercontent.com/pigshell/india-census-2011/master/pca-full.csv | MIT | 1,920 | a356032a0d48917a95196a94d4a2e9b5 |
| `pca-colnames.csv` | Column-name lookup for the PCA files | https://raw.githubusercontent.com/pigshell/india-census-2011/master/pca-colnames.csv | MIT | 87 | 37e533b5cd52db8d37a3d286eef4518c |
| `nfhs4_district-wise.csv` | NFHS-4 (2015-16) district fact sheets, 93 indicators, long format | https://raw.githubusercontent.com/HindustanTimesLabs/nfhs-data/master/nfhs_district-wise.csv (github.com/HindustanTimesLabs/nfhs-data, from rchiips.org/nfhs) | MIT (mirror); survey data © IIPS/MoHFW | 59,240 | original download cb926c495830b4b869930e878b4c5e80; committed copy has CR line endings converted to LF, cp1252 encoding kept |
| `nfhs_indicator_lookup.csv` | Indicator number → description | https://raw.githubusercontent.com/HindustanTimesLabs/nfhs-data/master/nfhs_indicator_lookup.csv | MIT | 93 | 351595cb0b3f7c0825672003f2d4aedd |
| `imd_subdivision_rainfall_1901_2017.csv` | IMD monthly/seasonal rainfall by meteorological sub-division, 1901-2017 | https://raw.githubusercontent.com/dcsavinod/weather-and-rainfall-data-from-1901-to-2022/main/Rainfall_State_Analysis_India_1901_2017.csv (from data.gov.in "Sub Divisional Monthly Rainfall from 1901 to 2017") | No license file on mirror; source is data.gov.in (GODL-India) | 4,187 | cc7da67d7f19bf8a7a5182d2b40f55dd |
| `subdivision_to_state.csv` | Hand-written mapping of the 36 IMD sub-divisions to the 33 states/UTs in the dataset | this repository | GPL-3.0-or-later | 44 | — |

Notes
- Telangana was carved out of Andhra Pradesh in 2014. Census 2011 lists its districts under state code 28
  (district codes 532-541); the NFHS-4 mirror does the same. The join scripts handle this explicitly.
- In the NFHS-4 mirror, indicator 78 (pregnant women who are anaemic) is negative for 290 districts with otherwise
  plausible magnitudes, a sign artefact of the scrape; those values are set to missing rather than sign-flipped
  (the indicator is not used in any model). No other selected indicator has values outside 0-100.
- 79 districts in the crop/health data were created after Census 2011 and have Census district code 0 in
  the LGD file; they receive NA for Census and NFHS variables (see `outputs/tables/join_report.md`).
- Puducherry is mapped to the Tamil Nadu sub-division (its main enclave); Mahe and Yanam are ignored.
- States spanning several sub-divisions use the unweighted mean of those sub-divisions.
- Data on GDP, beds, tap water, child marriage and nitrate were collected by the original authors; see the
  README for their sources.
