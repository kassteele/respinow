#
# This script manages the cron job
#

# Load packages
library(cronR)

# Add cron job
# Log will be added in same dir as automated_submission.R
cron_add(
  command = cron_rscript(
    rscript = "~/Surfdrive/R_topics/nowcasting/Github_repositories/respinow/automation/automated_submission.R",
    workdir = "~/Surfdrive/R_topics/nowcasting/Github_repositories/respinow",
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
