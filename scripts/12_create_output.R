#
# Create output for submission
#

# See https://github.com/KITmetricslab/RESPINOW-Hub/wiki/Submission-format
# for the submission format
fun_create_output <- function(data) {
  data |>
    # Combine splits
    bind_rows() |>
    # target_end_date corresponds the the date column in the original data
    # Always a Sunday
    rename(
      target_end_date = date) |>
    mutate(
      # Add forecast_date
      # Always a Thursday
      forecast_date = forecast_date,
      # horizon is the difference (in weeks) between
      # target_end_date (Sunday) and forecast_date - 4 days (Friday -> Sunday)
      horizon = as.integer(target_end_date - (forecast_date - days(4)))/7L) |>
    # Nowcasts should be submitted back until horizon -3 weeks
    filter(
      horizon >= -3L) |>
    # Reshape into long format
    pivot_longer(
      cols = starts_with("N_"),
      names_sep = "_",
      names_to = c(NA, "type", "quantile"),
      values_to = "value") |>
    # Reorder colums
    select(
      location, age_group, forecast_date, target_end_date, horizon, type, quantile, value)
}

# Apply fun_create_output() function
output_icosari_sari <- nowcast_icosari_sari_split |> fun_create_output()
output_survstat_infl <- nowcast_survstat_infl_split |> fun_create_output()
output_survstat_rsv <- nowcast_survstat_rsv_split |> fun_create_output()
