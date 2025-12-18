#
# Clean data
#

# Function that applies general data cleaning steps
fun_general_cleaning <- function(data) {
  data |>
    # We don't need these columns
    select(
      -c(year, week)) |>
    # Mutations
    mutate(
      # Location and age group as factors, with levels in given order
      location = location |> fct_inorder(),
      age_group = age_group |> fct_inorder()) |>
    # Tidy data
    # The delay comes from the number in the value_{**}d columns
    # The true number of cases by date and delay is called n_true
    pivot_longer(
      cols = starts_with("value"),
      names_to = "delay",
      names_pattern = "value_([-+]?\\d+)w",
      names_transform = list(delay = as.integer),
      values_to = "n_true",
      values_transform = list(n_true = as.integer),
      values_drop_na = TRUE) |>
    # Relocate date before delay
    relocate(
      date, .before = delay) |>
    # Arrange records
    arrange(
      location, age_group, date, delay)
}

# Apply fun_general_cleaning()
data_icosari_sari <- data_icosari_sari_raw |> fun_general_cleaning()
data_survstat_influenza <- data_survstat_influenza_raw |> fun_general_cleaning()
data_survstat_rsv <- data_survstat_rsv_raw |> fun_general_cleaning()
