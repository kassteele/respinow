#
# Fit models
#

# About the models:
# - Each split gets its own model and nowcast
# - Fit the same model to each pathogen
# - The quasi-Poisson (~ NB1 model with linear variance) shows a better fit than the NB2 model with quadratic variance
fun_fit_model_split <- list(
  # DE_00
  function(data) {
    if (nrow(data) == 0) return(NULL)
    bam(
      formula = n_rep ~
        s(date_trans, bs = "ps", k = 20) +
        s(delay_trans, bs = "ps", k = 5) +
        s(I_max_delay, bs = "re"),
      family = quasipoisson,
      data = data,
      select = TRUE,
      discrete = TRUE)
  },
  # DE_not00
  function(data) {
    if (nrow(data) == 0) return(NULL)
    bam(
      formula = n_rep ~
        s(date_trans, bs = "ps", k = 20) +
        s(delay_trans, bs = "ps", k = 5) +
        s(I_max_delay, bs = "re") +
        s(age_group, bs = "re") +
        ti(age_group, date_trans, bs = c("re", "ps")) +
        ti(age_group, delay_trans, bs = c("re", "ps")) +
        ti(age_group, I_max_delay, bs = c("re", "re")),
      family = quasipoisson,
      data = data,
      select = TRUE,
      discrete = TRUE)
  },
  # notDE_00
  function(data) {
    if (nrow(data) == 0) return(NULL)
    bam(
      formula = n_rep ~
        s(date_trans, bs = "ps", k = 20) +
        s(delay_trans, bs = "ps", k = 5) +
        s(I_max_delay, bs = "re") +
        s(location, bs = "re") +
        ti(location, date_trans, bs = c("re", "ps")) +
        ti(location, delay_trans, bs = c("re", "ps")) +
        ti(location, I_max_delay, bs = c("re", "re")),
      family = quasipoisson,
      data = data,
      select = TRUE,
      discrete = TRUE)
  }
)
# Apply fun_fit_model_split() function
fit_icosari_sari_split <- map2(
  .x = data_icosari_sari_split,
  .y = fun_fit_model_split,
  .f = \(data, fun_fit_model) fun_fit_model(data))
fit_survstat_influenza_split <- map2(
  .x = data_survstat_influenza_split,
  .y = fun_fit_model_split,
  .f = \(data, fun_fit_model) fun_fit_model(data))
