#
# Split fit data
#

# Split data in three ways:
# 1. DE_00: total DE - total age,
# 2. DE_not00: total DE - age groups
# 3. notDE_00: states - total age
fun_split_fit_data <- function(data) {
  list(
    DE_00    = data |> filter(location == "DE" & age_group == "00+"),
    DE_not00 = data |> filter(location == "DE" & age_group != "00+"),
    notDE_00 = data |> filter(location != "DE" & age_group == "00+"))
}  

# Apply fun_split_fit_data()
data_icosari_sari_split <- data_icosari_sari_fit |> fun_split_fit_data()
data_survstat_infl_split <- data_survstat_infl_fit |> fun_split_fit_data()
data_survstat_rsv_split <- data_survstat_rsv_fit |> fun_split_fit_data()
