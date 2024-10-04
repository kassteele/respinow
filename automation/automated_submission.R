#
# This script is called by the Cron job to do the automated submission
#

# Run init once
source(file = "scripts/01_initialise.R")

# Repeat this part
repeat {
  # Import data and check consistancy
  source(file = "scripts/02_import_raw_data.R")
  source(file = "scripts/03_check_data_forecast_date.R")

  # Depending on consistancy and time of day
  if (is_consistent_icosari_sari & is_consistent_survstat_influenza) {
    # If consistent, break the loop and run submission masterscript
    break
  } else if (hour(now()) < 17) {
    # Else, if the time is before 17:00, wait for 30 minutes and repeat loop
    Sys.sleep(time = 1800)
  } else {
    # Else, stop trying and quit R
    q(save = "no")
  }
}

# Run submission masterscript
source(file = "automation/00_masterscript_submission.R")
