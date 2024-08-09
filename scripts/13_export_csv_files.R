#
# Export csv files
#

export_csv_file <- function(data, model) {
  # Get datasource and pathogen
  tmp <- data |> substitute() |> deparse() |> str_split(pattern = "_") |> unlist()
  datasource <- tmp[2]
  pathogen <- tmp[3]

  # Set output folder for given model, datasource and pathogen
  output_folder <- str_glue("output/{datasource}/{pathogen}/{model}")

  # Set filename for given forecast_date
  filename <- str_glue("{output_folder}/{forecast_date}-{datasource}-{pathogen}-{model}.csv")

  # Create output folder if it does not exists
  if (!file.exists(output_folder)) {
    dir.create(
      path = output_folder,
      recursive = TRUE)
  }

  # Write csv if it does not exists
  if (!file.exists(filename)) {
    data |> write_csv(
      file = filename,
      quote = "none")
  }
}

# Apply export_csv_file() function
output_icosari_sari |> export_csv_file(model = "RIVM-GAM")
output_survstat_influenza |> export_csv_file(model = "RIVM-GAM")
