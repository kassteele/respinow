#
# Stage-commit-push files
#

# Set R working dir to the local_folder/repos_name
setwd(dir = str_glue("{local_folder}/{repos_name}"))

# Stage files
system(str_glue("git add {str_c(files_to, collapse = ' ')}"))

# Commit
system(str_glue("git commit -m 'Update nowcasts (RIVM) {forecast_date}'"))

# Push submission branch to origin_user_name/repos_name
system("git push --set-upstream origin submission")

# Set R working dir to RStudio project dir
setwd(dir = project_folder)
