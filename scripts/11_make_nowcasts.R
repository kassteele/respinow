#
# Make nowcasts
#

# Make the nowcasts based on the model fits
fun_make_nowcast <- function(data, fit, forecast_date) {

  # Return nothing if there is no fit
  if (is.null(fit)) return(NULL)

  # Filter records outside and inside the reporting triangle
  # Outside: for these records we are going to predict the counts
  # Inside: these records are needed for the already reported counts,
  #         but we only the dates corresponding to the dates outside the triangle,
  #         not the entire date range that was used for fitting
  data_outside_triangle <- data |>
    filter(
      is.na(n_rep))
  data_inside_triangle <- data |>
    filter(
      !is.na(n_rep) & date %in% (data_outside_triangle |> pull(date) |> unique()))

  # Construct the corresponding model matrix
  X <- predict(
    object = fit,
    newdata = data_outside_triangle,
    type = "lpmatrix")

  # Set seed
  set.seed(1)

  # Extract coefficients and overdispersion parameter alpha
  # - beta is sampled from a multivariate normal distribution
  # - alpha is fixed
  beta <- rmvn(
    n = n_sim,
    mu = coef(fit),
    V = vcov(fit))
  alpha <- fit$sig2 - 1

  # The expected number of counts follows from the model matrix X and beta
  # This is an nrow(X) x n_sim matrix
  mu <- exp(X %*% t(beta))

  # Counts outside the reporting triangle are sampled from
  # the predictive distribution, i.e. negative binomial
  #
  # See Hilbe (2011), 10.2, p298 for the relation between
  # the quasi-Poisson and the linear variance negative binomial model, NB1
  # The overdispersion parameter of the quasipoisson model is phi (= fit$sig2)
  # The variance of the corresponindg NB1 distribution is Var(y) = mu*phi = mu*(1 + alpha)
  # To generate random numbers from the NB1 distribution, use rnbinom(n = n, mu = mu, size = mu/alpha)
  #
  # This creates an nrow(X) x n_sim matrix column in data_outside_triangle
  # We use the column name n_rep here, because this makes the binding
  # with the records inside the triangle easier
  data_outside_triangle <- data_outside_triangle |>
    mutate(
      n_rep = rnbinom(
        n = n()*n_sim,
        mu = mu,
        size = mu/alpha) |>
        matrix(
          nrow = n(),
          ncol = n_sim))

  # Row-bind records inside and outside the reporting triangle
  # This automatically replicates n_rep inside the reporting triangle n_sim times
  # Arrange records as in the original data
  data_nowcast <- bind_rows(
    data_inside_triangle,
    data_outside_triangle) |>
    arrange(
      location, age_group, date, delay)

  # Summarise Monte Carlo samples
  data_nowcast <- data_nowcast |>
    # 1. Summarise n_rep by location, age_group and date
    #    i.e. sum over the delays, but still keep the Monte Carlo samples
    group_by(
      location, age_group, date) |>
    reframe(
      N = n_rep |> colSums()) |>
    # 2. Calculate the statistics by location, age_group and date
    #    i.e. summarise the Monte Carlo samples into single statistics
    group_by(
      location, age_group, date) |>
    summarise(
      N_mean_NA = N |> mean() |> round(),
      N_quantile_0.025 = N |> quantile(0.025) |> round(),
      N_quantile_0.1   = N |> quantile(0.1) |> round(),
      N_quantile_0.25  = N |> quantile(0.25) |> round(),
      N_quantile_0.5   = N |> quantile(0.5) |> round(),
      N_quantile_0.75  = N |> quantile(0.75) |> round(),
      N_quantile_0.9   = N |> quantile(0.9) |> round(),
      N_quantile_0.975 = N |> quantile(0.975) |> round(),
      .groups = "drop")

  # Return output
  return(data_nowcast)
}

# Apply fun_make_nowcast() function
# SurvStat data is one week ahead
nowcast_icosari_sari_split <- future_map2(
  .x = data_icosari_sari_split,
  .y = fit_icosari_sari_split,
  .f = \(data, fit) fun_make_nowcast(data, fit, forecast_date))
nowcast_survstat_influenza_split <- future_map2(
  .x = data_survstat_influenza_split,
  .y = fit_survstat_influenza_split,
  .f = \(data, fit) fun_make_nowcast(data, fit, forecast_date + weeks(1)))
nowcast_survstat_rsv_split <- future_map2(
  .x = data_survstat_rsv_split,
  .y = fit_survstat_rsv_split,
  .f = \(data, fit) fun_make_nowcast(data, fit, forecast_date + weeks(1)))
