# SPDX-License-Identifier: GPL-3.0-or-later
"""Step 4: assemble the district-year analysis panel and write the codebook.

Output: data/processed/panel.csv (one row per district-year), data/processed/codebook.md
"""
import numpy as np
import pandas as pd

from common import PROC, STATE_TO_ZONE, V_DOCUMENTED, log

KEYS = ["statelgdcode", "districtlgdcode", "year"]

DERIVED = {
    "zone": "Six-zone grouping of states (north/east/west/south/central/north_east); corrected spelling, all states assigned",
    "female_pct": "Female share of births, % = v31 / (1000 + v31) * 100 (as in the original model)",
    "log_gdp": "log of state GDP (gdp, lakh rupees, current prices, by year)",
    "log_beds": "log of state hospital beds (time-invariant)",
    "log_tap": "log of district % households with tap water (NA where tap is 0 or missing)",
    "gdp_pc": "State GDP per person, rupees: gdp * 1e5 / state_pop_2011",
    "log_gdp_pc": "log of gdp_pc",
    "beds_per_lakh": "State hospital beds per 100,000 people (Census 2011 population)",
    "child_marriage_per_mn": "Reported child-marriage cases per million people (Census 2011 population)",
    "nitrate_missing": "1 if the state has no nitrate value that year",
    "state_pop_2011": "Census 2011 state population (Telangana split from undivided Andhra Pradesh)",
}
EXTERNAL = {
    "census_state": "Census 2011 state code (Telangana districts under 28)",
    "census_district": "Census 2011 district code; NA for districts created after 2011",
    "pop_2011": "Census 2011 district population",
    "lit_rate": "Census 2011 literacy rate, % of population aged 7+",
    "f_lit_rate": "Census 2011 female literacy rate, % of females aged 7+",
    "sc_st_share": "Census 2011 Scheduled Caste + Scheduled Tribe share of population, %",
    "agri_worker_share": "Census 2011 cultivators + agricultural labourers as % of all workers",
    "urban_share": "Census 2011 urban share of population, %",
    "nfhs_women_literate": "NFHS-4 (2015-16): women age 15-49 who are literate, %",
    "nfhs_married_before18": "NFHS-4: women age 20-24 married before age 18, %",
    "nfhs_anc4_visits": "NFHS-4: mothers with at least 4 antenatal care visits, %",
    "nfhs_ifa_100days": "NFHS-4: mothers who consumed iron-folic acid for 100+ days, %",
    "nfhs_institutional_births": "NFHS-4: institutional births, %",
    "nfhs_women_bmi_low": "NFHS-4: women with BMI below 18.5, %",
    "nfhs_pregnant_anaemic": "NFHS-4: pregnant women age 15-49 who are anaemic, %",
    "nfhs_women_anaemic": "NFHS-4: all women age 15-49 who are anaemic, %",
    "rain_annual": "IMD annual rainfall, mm (state mean of its meteorological sub-divisions)",
    "rain_jjas": "IMD June-September (monsoon) rainfall, mm (state mean of sub-divisions)",
    "rain_annual_anom": "Annual rainfall anomaly: z-score vs the sub-division's 1981-2010 mean/sd, averaged to state",
    "rain_jjas_anom": "Monsoon rainfall anomaly (z-score vs 1981-2010), averaged to state",
    "rain_jjas_anom_lag1": "Previous year's monsoon anomaly",
}
ORIGINAL = {
    "statelgdcode": "State LGD code", "districtlgdcode": "District LGD code", "year": "Year (2011-2016)",
    "state": "State/UT name", "district": "District name", "sdyid": "state+district+year id from the source file",
    "gdp": "State GDP by year (hand-collected, lakh rupees, current prices)",
    "beds": "State hospital beds (hand-collected, single year)",
    "tap": "District % households with tap water (hand-collected, single year)",
    "child_marriage": "State reported child-marriage cases by year (data.gov.in)",
    "nitrate": "State nitrate level in surface water by year (CPCB); NA for many state-years",
}


def crop_descriptions(cols):
    out = {}
    for c in cols:
        parts = c.split("_")
        if parts[0] in {"yi", "lyi", "yidev", "yigr"} and len(parts) >= 3:
            kind = {"yi": "Yield index (tonnes/ha)", "lyi": "log yield index", "yidev": "Yield shock: log index minus district 2011-16 mean",
                    "yigr": "log yield growth vs previous year"}[parts[0]]
            season, cat = parts[1], parts[2]
            lag = " (previous year)" if c.endswith("_lag1") else ""
            what = "all categories, area-weighted" if cat == "all" else f"{cat} crops"
            out[c] = f"{kind}{lag}: {season} season, {what}; NA if not grown"
    out.update({"area_total": "Sum of category-season areas (ha), all seasons pooled (gross cropped area proxy)",
                "share_foodgrain_area": "Share of area under foodgrain (RBI category) vs commercial crops",
                "n_categories": "Number of crop categories grown (any season)",
                "hhi_area": "Herfindahl index of area shares across crop categories (1 = single category)"})
    return out


def main() -> None:
    dy = pd.read_csv(PROC / "district_year.csv")
    cw = pd.read_csv(PROC / "crops_wide.csv")
    ed = pd.read_csv(PROC / "external_district.csv")
    sy = pd.read_csv(PROC / "external_state_year.csv")
    spop = pd.read_csv(PROC / "state_population_2011.csv")

    p = dy.merge(cw, on=KEYS, how="left", validate="1:1")
    p = p.merge(ed, on=["statelgdcode", "districtlgdcode"], how="left", validate="m:1")
    p = p.merge(sy, on=["state", "year"], how="left", validate="m:1")
    p = p.merge(spop[["statelgdcode", "state_pop_2011"]], on="statelgdcode", how="left", validate="m:1")
    assert len(p) == len(dy)
    p = p.copy()  # defragment after the merges

    p["zone"] = p.state.map(STATE_TO_ZONE)
    assert p.zone.notna().all(), f"states without zone: {sorted(p.loc[p.zone.isna(), 'state'].unique())}"
    p["female_pct"] = p.v31 / (1000 + p.v31) * 100
    p["log_gdp"] = np.log(p.gdp)
    p["log_beds"] = np.log(p.beds)
    p["log_tap"] = np.log(p.tap.where(p.tap > 0))
    p["gdp_pc"] = p.gdp * 1e5 / p.state_pop_2011
    p["log_gdp_pc"] = np.log(p.gdp_pc)
    p["beds_per_lakh"] = p.beds / p.state_pop_2011 * 1e5
    p["child_marriage_per_mn"] = p.child_marriage / p.state_pop_2011 * 1e6
    p["nitrate_missing"] = p.nitrate.isna().astype(int)

    p = p.sort_values(KEYS).reset_index(drop=True)
    p.to_csv(PROC / "panel.csv", index=False)
    log(f"panel rows={len(p)} cols={p.shape[1]} districts={p.districtlgdcode.nunique()}")

    # codebook
    desc = {}
    desc.update(ORIGINAL)
    desc.update({v: V_DOCUMENTED.get(v, "Undocumented in the source material (HMIS-style indicator)") for v in [f"v{i}" for i in range(1, 48)]})
    desc.update(crop_descriptions(cw.columns))
    desc.update(EXTERNAL)
    desc.update(DERIVED)
    lines = ["# Codebook for `data/processed/panel.csv`", "",
             "One row per district-year (2011-2016). Generated by `src/prep/04_build_panel.py`.", "",
             "Only 13 of the 47 HMIS indicator columns (`v1`-`v47`) are documented in the project report; "
             "the rest are carried unchanged and marked undocumented. Columns with a maximum above 100 are counts, "
             "the others percentages/ratios (inferred from their range, not from documentation).", "",
             "| Column | Description | Non-missing | Min | Median | Max |", "|---|---|---:|---:|---:|---:|"]
    for c in p.columns:
        s = p[c]
        if pd.api.types.is_numeric_dtype(s):
            stats = f"{s.notna().mean():.0%} | {s.min():.4g} | {s.median():.4g} | {s.max():.4g}"
        else:
            stats = f"{s.notna().mean():.0%} | | | "
        lines.append(f"| `{c}` | {desc.get(c, '')} | {stats} |")
    (PROC / "codebook.md").write_text("\n".join(lines) + "\n")
    log("wrote panel.csv, codebook.md")


if __name__ == "__main__":
    main()
