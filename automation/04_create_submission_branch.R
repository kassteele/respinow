#
# Create submission branch
#

# Set R working dir to the local_folder/repos_name
setwd(dir = str_glue("{local_folder}/{repos_name}"))

# Be sure to start in the main branch
system("git checkout main")

# Remove possible leftover submission branch
# You can ignore the error "branch 'submission' not found"
try(system("git branch -D submission"))

# Pull upstream repos into the current main branch
system("git pull upstream main")

# Create local branch "submission" and check out
system("git checkout -b submission")

# Set R working dir to RStudio project dir
setwd(dir = project_folder)
