# Rebuild everything: data preparation (Python) then analysis (R).
# Requires: .venv with requirements.txt installed; R with packages from R/install_packages.R
PY := $(CURDIR)/.venv/bin/python
R  := Rscript

.PHONY: all data analysis clean distclean

all: data analysis

data:
	cd src/prep && $(PY) 01_clean_raw.py && $(PY) 02_crop_features.py && $(PY) 03_external_join.py && $(PY) 04_build_panel.py

analysis:
	$(R) R/01_descriptives.R
	$(R) R/02_replicate_original.R
	$(R) R/03_main_models.R
	$(R) R/04_robustness.R
	$(R) R/05_other_outcomes.R
	$(R) R/06_figures.R
	$(R) R/07_render_readme.R

clean:
	rm -f data/processed/crops_long.csv data/processed/crops_wide.csv data/processed/district_year.csv data/processed/external_district.csv data/processed/external_state_year.csv data/processed/state_population_2011.csv
	rm -rf src/prep/__pycache__

distclean: clean
	rm -f data/processed/panel.csv data/processed/codebook.md outputs/tables/* outputs/figures/*
