#
# Apply location and age group filter
#

# # Helper function that shows if there is any data
# # on location and age group
# fun_any_data <- function(data) {
#   data |>
#     group_by(
#       location, age_group) |>
#     summarise(
#       across(
#         .cols = starts_with("value"),
#         .fns = \(x) (!is.na(x) & x != 0) |> any()),
#       .groups = "drop") |>
#     rowwise() |>
#     mutate(
#       any_data = c_across(cols = starts_with("value")) |> any(),
#       .keep = "unused")
# }
# 
# # Show if there is any data for locations and age groups
# # Provides information to filter on
# data_icosari_sari_raw |> fun_any_data()
# data_survstat_influenza_raw |> fun_any_data()
# data_survstat_pneu_raw |> fun_any_data()
# data_survstat_rsv_raw |> fun_any_data()

# Only information for DE 00+
data_icosari_sari_raw <- data_icosari_sari_raw |> 
  filter(
    age_group == "00+")

# As is
data_survstat_influenza_raw <- data_survstat_influenza_raw

# # As is
# data_survstat_pneu_raw <- data_survstat_pneu_raw

# Drop location DE-SN, because this is currently the only state
data_survstat_rsv_raw <- data_survstat_rsv_raw |> 
  filter(
    location != "DE-SN")
