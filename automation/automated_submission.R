#
# Automated submission
#

# Load packages
library(here)
library(stringr)

# These steps should be done only once:
# 1. Fork the repos RESPINOW-Hub to your own GitHub
# 2. Clone repos RESPINOW-Hub into local folder RESPINOW-Hub
if (!file.exists(here("RESPINOW-Hub"))) {
  # Be sure to set dir to folder were folder RESPINOW-Hub should be created
  # If you are in Nowcast-hub.Rproj, you are ok
  setwd(dir = here())
  system("git clone git@github.com:kassteele/RESPINOW-Hub.git")
}
# 3. Add upstream (= KITmetricslab/RESPINOW-Hub)
if (!any(any(grepl("upstream", system("git remote -v", intern = TRUE))))) {
  system("git remote add upstream git@github.com:KITmetricslab/RESPINOW-Hub.git")
  # Check, should contain
  # origin   git@github.com:kassteele/RESPINOW-Hub.git
  # upstream git@github.com:KITmetricslab/RESPINOW-Hub.git
  system("git remote -v")
}
# 4. Run in terminal: gh auth login
# Done

# Set forecast_date (Thursday)
# Because this script runs on Friday = today - 1 day
forecast_date <- Sys.Date() - 1

# Set dir to local repos
setwd(dir = here("RESPINOW-Hub"))

# Be sure to start in the main branch
system("git checkout main")

# Remove possible leftover submission branch
# You can ignore the error "cannot locate local branch 'submission'"
try(system("git branch -D submission"))

# Pull remote repository into the current local branch
system("git pull upstream main")

# Create local branch "submission" and check out
system("git checkout -b submission")

# Set dir to RStudio project dir
setwd(dir = here())

# Run the masterscript that does all calculations
source(file = "scripts/00_masterscript.R")

# Copy files with forecast_date from output folder to RESPINOW-Hub/submissions folder
files_from <- list.files(
  path = here("output/RIVM-GAM"),
  full.names = TRUE,
  recursive = TRUE,
  pattern = as.character(forecast_date))
files_to <- file.path(
  files_from |> dirname() |> str_replace("output/RIVM-GAM", "RESPINOW-Hub/submissions"),
  "RIVM-GAM",
  files_from |> basename())
file.copy(
  from = files_from,
  to = files_to)

# Set dir to local repos
setwd(dir = here("RESPINOW-Hub"))

# Stage files
system(str_glue("git add {files_to |> str_c(collapse = ' ')}"))

# Commit
system(str_glue("git commit -m 'Update nowcasts (RIVM) {forecast_date}'"))

# Push submission branch to my repository (origin)
system("git push --set-upstream origin submission")

# Create pull request
system(str_glue("gh pr create --title 'Update nowcasts (RIVM) {forecast_date}' --body 'Update nowcasts (RIVM)' --repo 'KITmetricslab/RESPINOW-Hub'"))

# Go back to main branch
system("git checkout main")
system("git push origin main")

# Remove local submission branch
system("git branch -D submission")

# Send confirmation e-mail
source(file = "../automation/send_e-mail.R")
