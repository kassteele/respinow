#
# Truncate reporting triangle
#

# The reporting triangle is truncated up to forecast_date minus 4 days (Thursday -> Sunday)
# In a real-time setting this happens naturally
# Create a new variable n_rep:
# - Set to NA     if date + delay >  forecast_date - days(4)
# - Set to n_true if date + delay <= forecast_date - days(4)
# This forced trunction is useful for evaluating nowcasts retrospectively
# by setting forecast_date to some Thursday in the past
fun_truncate_reporting_triangle <- function(data, forecast_date) {
  data |> 
    mutate(
      n_rep = if_else(
        condition = date + weeks(delay) > forecast_date - days(4),
        true = NA_integer_,
        false = n_true))
}

# Apply fun_truncate_reporting_triangle()
# SurvStat data is one week ahead
data_icosari_sari <- data_icosari_sari |> fun_truncate_reporting_triangle(forecast_date)
data_survstat_infl <- data_survstat_infl |> fun_truncate_reporting_triangle(forecast_date + weeks(1))
data_survstat_rsv <- data_survstat_rsv |> fun_truncate_reporting_triangle(forecast_date + weeks(1))
