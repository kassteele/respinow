#
# Check if dates in are consistant with forecast_date
#

# The dates given in the raw data are Sundays, i.e. the end day of a week
# The last date (Sunday) in the raw data should be equal to forecast_date (Thusday) minus 4 days (= Sunday)
fun_check_dates <- function(data, forecast_date) {
  data_name <- data |> substitute() |> deparse()
  last_date <- data |> slice_tail(n = 1) |> pull(date)
  is_consistant <- last_date == forecast_date - days(4)
  str_glue("{data_name} last date {last_date} is {if_else(is_consistant, '', 'NOT ')}consistant with forecast date {forecast_date}") |> 
    message()
}

# Apply fun_check_dates()
# SurvStat data is one week ahead
data_icosari_sari_raw |> fun_check_dates(forecast_date)
data_survstat_infl_raw |> fun_check_dates(forecast_date + weeks(1))
data_survstat_rsv_raw |> fun_check_dates(forecast_date + weeks(1))
