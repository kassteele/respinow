#
# Clone remote GitHub repository
#

# These steps should be done only once

# 1. Go to github.com/upstream_user_name/repos_name (a.k.a. upstream)
#    and fork this repos to your own GitHub

# 2. Clone the fork (a.k.a origin) into local_folder on your machine
#    Only do this if the folder does not exist
if (!file.exists(file.path(local_folder, repos_name))) {
  # Set R working dir to local_folder
  setwd(dir = local_folder)
  # Clone fork
  system(str_glue("git clone git@github.com:{origin_user_name}/{repos_name}.git"))
  # Set R working dir to local_folder/repos_name for step 4
  setwd(dir = file.path(local_folder, repos_name))
}

# 3. Add upstream
#    This is done to keep the fork in sync with the original (upstream) repository
#    Only do this if the upstream does not exist
if (!any(str_detect(string = system("git remote -v", intern = TRUE), pattern = "upstream"))) {
  system(str_glue("git remote add upstream git@github.com:{upstream_user_name}/{repos_name}.git"))
  # Check
  # The output of the command below should contain (2x, fetch and push)
  # origin   git@github.com:upstream_user_name/repos_name.git
  # upstream git@github.com:origin_user_name/repos_name.git
  system("git remote -v")
}

# 4. Authorise your machine to connect to github.com
#    This enables you to create pull requests from the command line
#    Follow the instructions this command gives you
#    Be sure to have your GitHub password ready
#    Only do this if you are not logged in
if (!any(str_detect(string = system("gh auth status", intern = TRUE), pattern = "Logged in"))) {
  system("gh auth login", wait = FALSE)
  # Check
  # The output should say you are logged in to github.com
  system("gh auth status")
}

# Set R working dir to project_folder
setwd(dir = project_folder)
