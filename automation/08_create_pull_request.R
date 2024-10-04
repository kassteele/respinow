#
# Create pull request
#

# Set R working dir to the local_folder/repos_name
setwd(dir = str_glue("{local_folder}/{repos_name}"))

system(str_glue("gh pr create --title 'Update nowcasts (RIVM) {forecast_date}' --body 'Update nowcasts (RIVM)' --repo '{upstream_user_name}/{repos_name}'"))

# Set R working dir to RStudio project dir
setwd(dir = project_folder)
