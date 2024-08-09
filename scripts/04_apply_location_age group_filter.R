#
# Apply location and age group filter
#

# Helper function that shows if there is any data
# on location and age group
fun_any_data <- function(data) {
  data_name <- data |> substitute() |> deparse()
  data |>
    group_by(
      data_name = data_name, location, age_group) |>
    summarise(
      across(
        .cols = starts_with("value"),
        .fns = \(x) (!is.na(x) & x != 0) |> any()),
      .groups = "drop") |>
    rowwise() |>
    mutate(
      any_data = c_across(cols = starts_with("value")) |> any(),
      .keep = "unused")
}

# Show if there is any data for locations and age groups
# Provides information to filter on
data_icosari_sari_raw |> fun_any_data()
data_survstat_influenza_raw |> fun_any_data()

# As is
data_icosari_sari_raw <- data_icosari_sari_raw
data_survstat_influenza_raw <- data_survstat_influenza_raw

