# SPDX-License-Identifier: GPL-3.0-or-later
"""Step 1: tidy the raw merged dataset.

Input : data/raw/main_final.csv  (one row per district x year x season x crop category)
Output: data/processed/crops_long.csv   cleaned crop rows (constant columns dropped, `index` renamed)
        data/processed/district_year.csv one row per district-year with the annual columns only

The v-columns and the hand-added state/district variables are annual: the script asserts they are
constant within a district-year before collapsing.
"""
import pandas as pd

from common import PROC, RAW, SEASON_KEY, CATEGORY_KEY, log

KEYS = ["statelgdcode", "districtlgdcode", "year"]
ANNUAL = ["state", "district", "sdyid"] + [f"v{i}" for i in range(1, 48)] + \
         ["gdp", "beds", "tap", "child_marriage", "nitrate"]
CONSTANT_COLS = ["country", "_merge", "v48"]  # single value in the whole file
CROP_COLS = ["rowid", "season", "cropcategory", "rbicat", "areahectares", "productiontonnes",
             "yieldtonneshectare", "yield_area", "yield_area_cc_total", "area_cc_total", "yield_index",
             "sdcsyid", "sd_cc_syid"]


def main() -> None:
    df = pd.read_csv(RAW / "main_final.csv", low_memory=False)
    log(f"raw rows={len(df)} cols={df.shape[1]}")
    for c in CONSTANT_COLS:
        assert df[c].nunique(dropna=False) == 1, f"{c} is not constant"
    df = df.drop(columns=CONSTANT_COLS).rename(columns={"index": "yield_index"})
    df["season"] = df["season"].map(SEASON_KEY)
    df["cropcategory"] = df["cropcategory"].map(CATEGORY_KEY)
    assert df["season"].notna().all() and df["cropcategory"].notna().all()
    assert not df.duplicated(KEYS + ["season", "cropcategory"]).any(), "grain is not district-year-season-category"

    # annual columns must not vary within a district-year
    nun = df.groupby(KEYS)[ANNUAL].nunique(dropna=False)
    bad = nun.columns[(nun > 1).any()].tolist()
    assert not bad, f"columns vary within district-year: {bad}"

    dy = df.groupby(KEYS, as_index=False)[ANNUAL].first()
    log(f"district-years={len(dy)} districts={dy.districtlgdcode.nunique()} states={dy.state.nunique()}")

    PROC.mkdir(parents=True, exist_ok=True)
    df[KEYS + CROP_COLS].to_csv(PROC / "crops_long.csv", index=False)
    dy.to_csv(PROC / "district_year.csv", index=False)
    log("wrote crops_long.csv, district_year.csv")


if __name__ == "__main__":
    main()
