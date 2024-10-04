#
# Submission masterscript
#

source(file = "automation/01_initialise.R")
source(file = "automation/02_clone_github_repos.R")
source(file = "automation/03_pull_upstream.R")
source(file = "automation/04_create_submission_branch.R")
source(file = "automation/05_run_masterscript_nowcast.R")
source(file = "automation/06_copy_files.R")
source(file = "automation/07_stage_commit_push_files.R")
source(file = "automation/08_create_pull_request.R")
source(file = "automation/09_remove_submission_branch.R")
source(file = "automation/10_send_telegram_message.R")
