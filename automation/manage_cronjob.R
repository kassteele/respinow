#
# This script manages the cron job
#

# Load packages
library(cronR)
library(stringr)

# Path of the automation script
# Get user home dir, because ~ will not work from the Linux command line
user_home <- Sys.getenv("HOME")
automation_script <- file.path(user_home, "Surfdrive/R_topics/nowcasting/Github_repositories/respinow/automation/automated_submission.R")
automation_dir <- dirname(automation_script)

# Add cron job
# The workdir will be set one dir higher than automation_dir
# This is the project directory
cron_add(
  command = cron_rscript(
    rscript = automation_script,
    workdir = dirname(automation_dir),
    log_append = FALSE),
  frequency = "daily",
  days_of_week = 5,
  at = "10:00",
  id = "respinow",
  ask = FALSE)

# List cron jobs
cron_ls()

# Remove job
cron_rm(
  id = "respinow",
  ask = FALSE)
