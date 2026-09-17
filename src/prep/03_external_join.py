# SPDX-License-Identifier: GPL-3.0-or-later
"""Step 3: attach external data via the Local Government Directory (LGD) district code.

Join spine: districtlgdcode -> data/external/district-lgd-codes.csv -> census_2011_district_code
            -> Census 2011 PCA (pigshell mirror) and NFHS-4 district fact sheets (Hindustan Times mirror).
Telangana (LGD state 36) districts carry Census-2011 codes under Andhra Pradesh (census state 28).
Districts created after 2011 have census code 0 in the LGD file and get NA for Census/NFHS fields.

Outputs:
  data/processed/external_district.csv    time-invariant district covariates (Census 2011, NFHS-4 2015-16)
  data/processed/external_state_year.csv  state-year rainfall (IMD sub-divisions averaged to states)
  data/processed/state_population_2011.csv
  outputs/tables/join_report.md
"""
import numpy as np
import pandas as pd

from common import EXT, PROC, OUT_TABLES, YEARS, log, write_csv

TELANGANA_CENSUS_DISTRICTS = set(range(532, 542))  # Adilabad..Khammam, census state 28
NFHS_OUT_OF_RANGE = 0

NFHS_INDICATORS = {
    12: "nfhs_women_literate",
    15: "nfhs_married_before18",
    30: "nfhs_anc4_visits",
    32: "nfhs_ifa_100days",
    40: "nfhs_institutional_births",
    72: "nfhs_women_bmi_low",
    78: "nfhs_pregnant_anaemic",
    79: "nfhs_women_anaemic",
}


def district_keys() -> pd.DataFrame:
    dy = pd.read_csv(PROC / "district_year.csv")
    d = dy.drop_duplicates(["statelgdcode", "districtlgdcode"])[["statelgdcode", "districtlgdcode", "state", "district"]]
    lgd = pd.read_csv(EXT / "district-lgd-codes.csv")
    d = d.merge(lgd[["district_code", "census_2011_district_code"]], left_on="districtlgdcode",
                right_on="district_code", how="left", validate="1:1").drop(columns="district_code")
    assert d.census_2011_district_code.notna().all(), "district missing from LGD file"
    d["census_state"] = d.statelgdcode.replace({36: 28})
    d["census_district"] = d.census_2011_district_code.where(d.census_2011_district_code > 0)
    return d


def census_pca(d: pd.DataFrame):
    pca = pd.read_csv(EXT / "pca-total.csv", dtype={"State": str, "District": str})
    pca["census_state"] = pca.State.astype(int)
    pca["census_district"] = pca.District.astype(int)
    full = pd.read_csv(EXT / "pca-full.csv", dtype={"State": str, "District": str})
    urban = full[full.TRU == "Urban"].assign(census_state=lambda f: f.State.astype(int),
                                             census_district=lambda f: f.District.astype(int))
    urban = urban[["census_state", "census_district", "TOT_P"]].rename(columns={"TOT_P": "urban_pop"})
    pca = pca.merge(urban, on=["census_state", "census_district"], how="left")
    pca["urban_pop"] = pca["urban_pop"].fillna(0)

    feat = pd.DataFrame({
        "census_state": pca.census_state, "census_district": pca.census_district,
        "pop_2011": pca.TOT_P,
        "lit_rate": pca.P_LIT / (pca.TOT_P - pca.P_06) * 100,
        "f_lit_rate": pca.F_LIT / (pca.TOT_F - pca.F_06) * 100,
        "sc_st_share": (pca.P_SC + pca.P_ST) / pca.TOT_P * 100,
        "agri_worker_share": (pca.MAIN_CL_P + pca.MAIN_AL_P + pca.MARG_CL_P + pca.MARG_AL_P) / pca.TOT_WORK_P * 100,
        "urban_share": pca.urban_pop / pca.TOT_P * 100,
    })
    out = d.merge(feat, on=["census_state", "census_district"], how="left", validate="m:1")

    # state population: Census 2011 totals, with Telangana split out of undivided Andhra Pradesh
    pca["state_key"] = np.where((pca.census_state == 28) & pca.census_district.isin(TELANGANA_CENSUS_DISTRICTS), 36,
                                pca.census_state)
    spop = pca.groupby("state_key", as_index=False).TOT_P.sum().rename(columns={"state_key": "statelgdcode", "TOT_P": "state_pop_2011"})
    spop = spop.merge(d[["statelgdcode", "state"]].drop_duplicates(), on="statelgdcode", how="inner")
    return out, spop


def nfhs4(d: pd.DataFrame) -> pd.DataFrame:
    n = pd.read_csv(EXT / "nfhs4_district-wise.csv", encoding="cp1252")
    n = n[n.indicator_number.isin(NFHS_INDICATORS)].copy()
    n["value"] = pd.to_numeric(n["total"].astype(str).str.replace(",", "", regex=False).replace({"*": np.nan, "nan": np.nan}),
                               errors="coerce")
    # every selected indicator is a percentage; the mirror contains a few impossible values (e.g. negative totals)
    bad = (n["value"] < 0) | (n["value"] > 100)
    global NFHS_OUT_OF_RANGE
    NFHS_OUT_OF_RANGE = int(bad.sum())
    n.loc[bad, "value"] = np.nan
    w = n.pivot_table(index=["state_census_code", "district_census_code"], columns="indicator_number", values="value", aggfunc="first")
    w = w.rename(columns=NFHS_INDICATORS).reset_index().rename(columns={"state_census_code": "census_state",
                                                                          "district_census_code": "census_district"})
    return d.merge(w, on=["census_state", "census_district"], how="left", validate="m:1")


def rainfall(states: pd.DataFrame) -> pd.DataFrame:
    r = pd.read_csv(EXT / "imd_subdivision_rainfall_1901_2017.csv")
    r = r.rename(columns={"SUBDIVISION": "subdivision", "YEAR": "year", "ANNUAL": "rain_annual", "June-September": "rain_jjas"})
    base = r[(r.year >= 1981) & (r.year <= 2010)].groupby("subdivision")[["rain_annual", "rain_jjas"]].agg(["mean", "std"])
    stats = pd.DataFrame({"subdivision": base.index,
                          "annual_mean": base[("rain_annual", "mean")].values, "annual_sd": base[("rain_annual", "std")].values,
                          "jjas_mean": base[("rain_jjas", "mean")].values, "jjas_sd": base[("rain_jjas", "std")].values})
    r = r.merge(stats, on="subdivision", how="left")
    r["rain_annual_anom"] = (r.rain_annual - r.annual_mean) / r.annual_sd
    r["rain_jjas_anom"] = (r.rain_jjas - r.jjas_mean) / r.jjas_sd
    m = pd.read_csv(EXT / "subdivision_to_state.csv")
    missing = set(m.subdivision) - set(r.subdivision)
    assert not missing, f"unknown sub-divisions in mapping: {missing}"
    sy = m.merge(r, on="subdivision").groupby(["state", "year"], as_index=False)[
        ["rain_annual", "rain_jjas", "rain_annual_anom", "rain_jjas_anom"]].mean()
    sy = sy[(sy.year >= 2010) & (sy.year <= 2016)]
    lag = sy[["state", "year", "rain_jjas_anom"]].assign(year=lambda f: f.year + 1).rename(columns={"rain_jjas_anom": "rain_jjas_anom_lag1"})
    sy = sy.merge(lag, on=["state", "year"], how="left")
    sy = sy[sy.year.isin(YEARS)]
    unmapped = set(states.state) - set(sy.state)
    assert not unmapped, f"states without rainfall: {unmapped}"
    return sy


def main() -> None:
    d = district_keys()
    d, spop = census_pca(d)
    d = nfhs4(d)
    sy = rainfall(d[["state"]].drop_duplicates())

    keep = ["statelgdcode", "districtlgdcode", "census_state", "census_district", "pop_2011", "lit_rate", "f_lit_rate",
            "sc_st_share", "agri_worker_share", "urban_share"] + list(NFHS_INDICATORS.values())
    write_csv(d[keep], PROC / "external_district.csv")
    write_csv(spop, PROC / "state_population_2011.csv")
    write_csv(sy, PROC / "external_state_year.csv")

    n_all = len(d)
    n_census_code = d.census_district.notna().sum()
    n_pca = d.pop_2011.notna().sum()
    n_nfhs = d.nfhs_women_anaemic.notna().sum()
    post2011 = d[d.census_district.isna()].groupby("state").district.apply(list)
    OUT_TABLES.mkdir(parents=True, exist_ok=True)
    lines = ["# External data join report", "",
             "Join key: `districtlgdcode` -> LGD directory -> Census 2011 district code (Telangana under census state 28).", "",
             "| Step | Districts matched | of |", "|---|---:|---:|",
             f"| LGD directory (code found) | {n_all} | {n_all} |",
             f"| Census 2011 district code available | {n_census_code} | {n_all} |",
             f"| Census 2011 PCA joined | {n_pca} | {n_all} |",
             f"| NFHS-4 district fact sheet joined | {n_nfhs} | {n_all} |",
             f"| States with Census population | {spop.state_pop_2011.notna().sum()} | {d.state.nunique()} |",
             f"| State-years with IMD rainfall | {len(sy)} | {d.state.nunique() * len(YEARS)} |", "",
             f"NFHS-4 values outside 0-100 (all selected indicators are percentages) set to missing: {NFHS_OUT_OF_RANGE}.", "",
             f"## Districts created after Census 2011 (no Census/NFHS values): {int(d.census_district.isna().sum())}", ""]
    for state, dl in post2011.items():
        lines.append(f"- {state}: {', '.join(dl)}")
    (OUT_TABLES / "join_report.md").write_text("\n".join(lines) + "\n")
    log(f"PCA matched {n_pca}/{n_all}; NFHS matched {n_nfhs}/{n_all}; state-years rainfall {len(sy)}")
    log("wrote external_district.csv, external_state_year.csv, state_population_2011.csv, join_report.md")


if __name__ == "__main__":
    main()
