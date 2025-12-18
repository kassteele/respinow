#
# Import raw data
#

# - Submission time will be Thursday afternoons (plus Friday morning if needed)
# - Forecast date needs to be a Thursday
# - Convention for horizons:
#   - Sunday four days before Thursday is 0 wk ahead
#   - Sunday three days after Thursday is 1 wk ahead
#
# Implications:
# - Icosari:
#   - New data arrives on Thursday
#   - Data go up to previous Sunday (in the past)
#   - By convention, the value_01w column is complete
# - SurvStat:
#   - New data arrives on Thursday
#   - Data go up to next Sunday (in the future)
#   - By convention, this introduces a value_-1w column, but it is still incomplete
#   - You may choose to use this column as additional information

# Function that imports raw data from hub
fun_import_raw_data <- function(url) {
  read_delim(
    file = file.path("https://raw.githubusercontent.com/KITmetricslab/RESPINOW-Hub/main/data", url),
    delim = ",",
    show_col_types = FALSE)
}

# Apply fun_import_raw_data()
data_icosari_sari_raw <- fun_import_raw_data("icosari/sari/reporting_triangle-icosari-sari-preprocessed.csv")
data_survstat_influenza_raw <- fun_import_raw_data("survstat/influenza/reporting_triangle-survstat-influenza-preprocessed.csv")
data_survstat_rsv_raw <- fun_import_raw_data("survstat/rsv/reporting_triangle-survstat-rsv-preprocessed.csv")
