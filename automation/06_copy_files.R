#
# Copy files
#

# Copy all files with given forecast_date
# from project_folder/output
# to repos_name/submissions/model_name
files_from <- list.files(
  path = str_glue("{project_folder}/output"),
  recursive = TRUE,
  pattern = as.character(forecast_date))
files_to <- str_glue("{local_folder}/{repos_name}/submissions/{files_from}")

# Copy
file.copy(
  from = str_glue("{project_folder}/output/{files_from}"),
  to = files_to)
