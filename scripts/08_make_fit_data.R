#
# Make data for fitting
#

fun_make_fit_data <- function(data, forecast_date) {
  data |>
    filter(
      # Use dates back to weeks_back_fit from forecast_date
      # Again we use forecast_date minus 4 days (Thursday -> Sunday)
      date > forecast_date - days(4) - weeks(weeks_back_fit) & date <= forecast_date - days(4)) |>
    mutate(
      # These variables are used in the model instead of date and delay:
      # - date_trans is the number days since min(date)
      # - delay_trans is the sqrt of delay, because this almost results in a log-linear delay effect
      #   Add 1 because SurvStat has delays -1 week
      date_trans = as.numeric(date - min(date)),
      delay_trans = (delay + 1L) |> sqrt(),
      # I_max_delay is an indicator variable for the maximum delay category
      I_max_delay = (delay == max_delay) |>
        as.integer() |>
        factor())
}

# Apply fun_make_fit_data()
# SurvStat data is one week ahead
data_icosari_sari_fit <- data_icosari_sari |> fun_make_fit_data(forecast_date)
data_survstat_influenza_fit <- data_survstat_influenza |> fun_make_fit_data(forecast_date + weeks(1))
