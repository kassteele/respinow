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
      # Sum columns value_10w and value_>10w
      # We do this because we would have expected an NA for value_>10w
      # at the 11th row from the bottom, but this is not the case... (why?)
      # Column value_10w now becomes value_>=10w
      value_10w = case_when(
        !is.na(value_10w) & !is.na(`value_>10w`) ~ value_10w + `value_>10w`,
        !is.na(value_10w) & is.na(`value_>10w`) ~ value_10w,
        is.na(value_10w) & is.na(`value_>10w`) ~ NA_real_),
      `value_>10w` = NULL,
      # # Data are collected from Monday to Sunday
      # # The given date is the date of that Sunday
      # # We find this is a very confusing convention
      # # Therefore, set the date to the Monday of that week (6 days earlier)
      # date = date - days(6L),
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
