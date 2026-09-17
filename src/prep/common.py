# SPDX-License-Identifier: GPL-3.0-or-later
"""Shared paths, name maps and helpers for the data-preparation scripts."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RAW = ROOT / "data" / "raw"
EXT = ROOT / "data" / "external"
PROC = ROOT / "data" / "processed"
OUT_TABLES = ROOT / "outputs" / "tables"

YEARS = list(range(2011, 2017))

SEASON_KEY = {"Kharif": "kharif", "Rabi": "rabi", "Summer": "summer", "Whole Year": "wholeyear"}
CATEGORY_KEY = {
    "Cash": "cash",
    "Cereal": "cereal",
    "Coarse Cereal": "coarse",
    "Pulse": "pulse",
    "Oilseed": "oilseed",
    "Horticulture": "hort",
}

# Six-zone grouping used by the original ANOVA script, with the misspellings fixed
# ("Orissa" -> Odisha, "Kerela" -> Kerala) and the seven previously unassigned
# states/UTs placed by geography.
ZONES = {
    "north": ["Himachal Pradesh", "Punjab", "Uttarakhand", "Uttar Pradesh", "Haryana",
              "Jammu And Kashmir", "Delhi", "Chandigarh"],
    "east": ["Bihar", "Odisha", "Jharkhand", "West Bengal", "Andaman And Nicobar Islands"],
    "west": ["Rajasthan", "Gujarat", "Goa", "Maharashtra"],
    "south": ["Andhra Pradesh", "Telangana", "Karnataka", "Kerala", "Tamil Nadu", "Puducherry"],
    "central": ["Madhya Pradesh", "Chhattisgarh"],
    "north_east": ["Assam", "Sikkim", "Nagaland", "Meghalaya", "Manipur", "Mizoram", "Tripura",
                   "Arunachal Pradesh"],
}
STATE_TO_ZONE = {s: z for z, states in ZONES.items() for s in states}

# Health-indicator columns whose meaning is documented in the project report.
V_DOCUMENTED = {
    "v12": "% of women discharged <48h after delivery (public institutions)",
    "v15": "% institutional deliveries (of reported deliveries)",
    "v16": "% safe deliveries (of reported deliveries)",
    "v25": "% reported live births (of reported births)",
    "v28": "% newborns weighing <2.5 kg (of newborns weighed)",
    "v31": "Sex ratio at birth (females per 1000 males)",
    "v40": "% infant deaths due to sepsis (of reported infant deaths)",
    "v41": "% infant deaths due to asphyxia (label from legacy Q2B41S.R: 'lbw'; ambiguous)",
    "v42": "% infant deaths due to low birth weight (of reported infant deaths)",
    "v43": "% infant deaths due to pneumonia",
    "v44": "% infant deaths due to diarrhoea",
    "v45": "% infant deaths due to fever",
    "v46": "% infant deaths due to measles",
}


def log(msg: str) -> None:
    print(f"[prep] {msg}", flush=True)


# Floating-point results differ in their last bits between platforms (BLAS and SIMD differences), which
# changes the shortest round-trip text that `to_csv` writes even when the numbers are identical to any
# precision anyone reads. Writing 10 significant digits keeps the committed files byte-identical across
# machines; it is far more precision than the analysis uses.
CSV_FLOAT_FORMAT = "%.10g"


def write_csv(df, path) -> None:
    """Write a data frame as CSV with a platform-stable float representation."""
    df.to_csv(path, index=False, float_format=CSV_FLOAT_FORMAT)
