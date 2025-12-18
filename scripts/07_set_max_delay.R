#
# Set maximum delay
#

fun_set_max_delay <- function(data) {
  # Modified sum function
  # If all x is NA, then return NA, not 0 as sum() does
  sum_na <- function(x) {
    if (all(is.na(x))) {
      NA_integer_
    } else {
      sum(x, na.rm = TRUE)
    }
  }

  # Set a maximum delay to a given value: max_delay (see script 01_initialize.R)
  # This is sometime needed if there are very long delays present
  # Once set, aggregate all delays >= max_delay into delay = max_delay
  data |>
    mutate(
      delay = if_else(
        condition = delay >= max_delay,
        true = max_delay,
        false = delay)) |>
    group_by(
      location, age_group, date, delay) |>
    # n_true never contains NA's -> can safely use sum() function
    # n_rep may contain only NA's after a forced truncation to forecast_date -> use sum_na function()
    summarise(
      n_true = sum(n_true),
      n_rep = sum_na(n_rep),
      .groups = "drop") |>
    # Complete reporting matrix by date and delay
    # This sets n_true and n_rep to NA outside the reporting triangle
    # We need this explicit NA's to make the nowcasts
    complete(
      nesting(location, age_group), date, delay)
}

# Apply fun_set_max_delay()
data_icosari_sari <- data_icosari_sari |> fun_set_max_delay()
data_survstat_influenza <- data_survstat_influenza |> fun_set_max_delay()
data_survstat_rsv <- data_survstat_rsv |> fun_set_max_delay()
