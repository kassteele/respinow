#
# Export csv files
#

export_csv_file <- function(data, path) {
  # Get datasource and pathogen
  tmp <- data |> substitute() |> deparse() |> str_split(pattern = "_") |> unlist()
  datasource <- tmp[2]
  pathogen <- tmp[3]

  # Path and filename for given forecast_date
  filename <- str_glue("output/{path}/{datasource}/{pathogen}/{forecast_date}-{datasource}-{pathogen}-RIVM-GAM.csv")

  # If the csv does not exists, write it
  if (!file.exists(filename)) {
    data |> write_csv(
      file = filename,
      quote = "none")
  }
}

# Apply export_csv_file() function
output_icosari_sari |> export_csv_file(path = "RIVM-GAM")
output_survstat_influenza |> export_csv_file(path = "RIVM-GAM")
output_survstat_rsv |> export_csv_file(path = "RIVM-GAM")
