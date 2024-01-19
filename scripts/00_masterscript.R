#
# Masterscript RESPINOW-Hub
#

source(file = "scripts/01_initialise.R")
source(file = "scripts/02_import_raw_data.R")
source(file = "scripts/03_check_data_forecast_date.R")
source(file = "scripts/03_apply_location_age group_filter.R")
source(file = "scripts/04_clean_data.R")
source(file = "scripts/05_truncate_reporting_triangle.R")
source(file = "scripts/06_set_max_delay.R")
source(file = "scripts/07_make_fit_data.R")
source(file = "scripts/08_split_fit_data.R")
source(file = "scripts/10_fit_models.R")
source(file = "scripts/11_make_nowcasts.R")
source(file = "scripts/12_create_output.R")
source(file = "scripts/13_export_csv_files.R")
