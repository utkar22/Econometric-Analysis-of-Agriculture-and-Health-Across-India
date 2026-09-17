# SPDX-License-Identifier: GPL-3.0-or-later
"""Step 2: district-year crop features from the long crop table.

Replaces the legacy `cash_index`/`cereal_index` construction (which took the yield index of whichever
crop row happened to come first in the CSV) with explicit per-season, per-category columns.

Output: data/processed/crops_wide.csv, one row per district-year with
  yi_<season>_<cat>        yield index (tonnes/ha) of that category in that season; NA if not grown
  lyi_<season>_<cat>       log yield index (NA when not grown or when the index is 0: 261 raw rows)
  yidev_<season>_<cat>     log index minus the district's own 2011-16 mean log index (within-district shock)
  yi_<season>_<cat>_lag1   previous year's yield index (same district/season/category)
  yigr_<season>_<cat>      log growth vs previous year
  lyi_<season>_all         area-weighted mean of category log indices in that season
  yidev_<season>_all       area-weighted mean of category shocks in that season
  area_total, share_foodgrain_area, n_categories, hhi_area   cropping structure (all seasons pooled)
"""
import numpy as np
import pandas as pd

from common import PROC, SEASON_KEY, CATEGORY_KEY, log, write_csv

KEYS = ["statelgdcode", "districtlgdcode", "year"]
SEASONS = list(SEASON_KEY.values())
CATS = list(CATEGORY_KEY.values())


def main() -> None:
    cl = pd.read_csv(PROC / "crops_long.csv")
    cl["lyi"] = np.log(cl["yield_index"].where(cl["yield_index"] > 0))
    g = ["statelgdcode", "districtlgdcode", "season", "cropcategory"]

    # within-district deviation of log index (needs >= 3 years of that series)
    grp = cl.groupby(g)["lyi"]
    cl["yidev"] = cl["lyi"] - grp.transform("mean")
    cl.loc[grp.transform("count") < 3, "yidev"] = np.nan

    # lag and growth on the explicit key, not on row adjacency
    prev = cl[g + ["year", "yield_index", "lyi"]].copy()
    prev["year"] += 1
    prev = prev.rename(columns={"yield_index": "yi_lag1", "lyi": "lyi_lag1"})
    cl = cl.merge(prev, on=g + ["year"], how="left")
    cl["yigr"] = cl["lyi"] - cl["lyi_lag1"]

    # wide: one column per season x category
    wide = cl.pivot_table(index=KEYS, columns=["season", "cropcategory"],
                          values=["yield_index", "lyi", "yidev", "yi_lag1", "yigr"], aggfunc="first")
    prefix = {"yield_index": "yi", "lyi": "lyi", "yidev": "yidev", "yi_lag1": "yi", "yigr": "yigr"}
    suffix = {"yi_lag1": "_lag1"}
    wide.columns = [f"{prefix[v]}_{s}_{c}{suffix.get(v, '')}" for v, s, c in wide.columns]
    wide = wide.reset_index()

    # season-level area-weighted aggregates
    def wavg(frame, col):
        w = frame["area_cc_total"].where(frame[col].notna())
        num = (frame[col] * w).sum()
        den = w.sum()
        return num / den if den > 0 else np.nan

    agg_rows = []
    for (s, d, y, season), f in cl.groupby(KEYS + ["season"]):
        agg_rows.append({"statelgdcode": s, "districtlgdcode": d, "year": y,
                         f"lyi_{season}_all": wavg(f, "lyi"), f"yidev_{season}_all": wavg(f, "yidev")})
    agg = pd.DataFrame(agg_rows).groupby(KEYS, as_index=False).first()
    wide = wide.merge(agg, on=KEYS, how="left")

    # cropping structure, all seasons pooled
    st = cl.groupby(KEYS).apply(lambda f: pd.Series({
        "area_total": f["area_cc_total"].sum(),
        "share_foodgrain_area": f.loc[f["rbicat"] == "Foodgrain", "area_cc_total"].sum() / f["area_cc_total"].sum(),
        "n_categories": f["cropcategory"].nunique(),
        "hhi_area": ((f.groupby("cropcategory")["area_cc_total"].sum() / f["area_cc_total"].sum()) ** 2).sum(),
    }), include_groups=False).reset_index()
    wide = wide.merge(st, on=KEYS, how="left")

    log(f"crops_wide rows={len(wide)} cols={wide.shape[1]}")
    for season in ("kharif", "rabi"):
        for cat in ("cash", "cereal"):
            col = f"yi_{season}_{cat}"
            log(f"  {col}: non-missing {wide[col].notna().mean():.1%}")
    write_csv(wide, PROC / "crops_wide.csv")
    log("wrote crops_wide.csv")


if __name__ == "__main__":
    main()
