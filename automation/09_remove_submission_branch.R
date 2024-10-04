#
# Remove submission branch
#

# Set R working dir to the local_folder/repos_name
setwd(dir = str_glue("{local_folder}/{repos_name}"))

# Go back to main branch
system("git checkout main")
system("git push origin main")

# Remove local submission branch
system("git branch -D submission")

# Set R working dir to RStudio project dir
setwd(dir = project_folder)
