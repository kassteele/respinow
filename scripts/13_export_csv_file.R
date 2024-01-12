#
# Export csv files
#

export_csv_file <- function(data, path) {
  # Path and filename for given forecast_date
  filename <- str_glue("output/{path}/{forecast_date}-{str_replace(path, '/', '-')}-RIVM-GAM.csv")
  
  # If the csv does not exists, write it
  # if (!file.exists(filename)) {
    data |> write_csv(
      file = filename,
      quote = "none")
  # }
}

# Apply export_csv_file() function
output_icosari_sari |>  export_csv_file(path = "icosari/sari")
output_survstat_infl |> export_csv_file(path = "survstat/influenza")
output_survstat_rsv |> export_csv_file(path = "survstat/rsv")
