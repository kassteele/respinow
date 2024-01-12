#
# This script manages the cron job
#

# Load packages
library(cronR)

# Add cron job
# This job runs on server rs4.rivm.nl
# Log will be added in same dir as automated_submission.R
cron_add(
  command = cron_rscript(
    rscript = "/home/kasstvdj/Scripts/respinow/automation/automated_submission.R",
    workdir = "/home/kasstvdj/Scripts/respinow",
    log_append = FALSE),
  frequency = "daily",
  days_of_week = 5,
  at = "9:00",
  id = "respinow",
  ask = FALSE)

# List cron jobs
cron_ls()

# Remove job
cron_rm(
  id = "respinow",
  ask = FALSE)
