#
# Initialise
#

# Load packages
library(tidyverse)
library(mgcv)

# Set time locale to English
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF-8")

# Weeks start on Mondays
options(lubridate.week.start = 1)

# Set maximum delay (weeks)
# Also see scripts 04_clean_data and 07_set_max_delay.R
max_delay <- 10L

# Set the number of weeks back to be used for fitting, especially for
# the estimation of the delay distribution
# Here we use 1 year, because many pathogens show almost no cases during summertime,
# resulting in a very unstable delay estimate
# Also see script 08_make_fit_data.R
weeks_back_fit <- 52L

# Set forecast date
# New data is available on Thursday or Friday
# Forecast date needs to be a Thursday
# Given today's date, find the previous Thursday
forecast_date <- today() |>
  floor_date(unit = "week", week_start = 4)

# Number of Monte Carlo simulations to use for predictive distribution
n_sim <- 5000L
