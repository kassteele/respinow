#
# Pull upstream
#

# Set R working dir to the local_folder/repos_name
setwd(dir = str_glue("{local_folder}/{repos_name}"))

# Be sure to start in the main branch
system("git checkout main")

# Pull upstream repos into the current main branch
system("git pull upstream main")

# Set R working dir to project_folder
setwd(dir = project_folder)
