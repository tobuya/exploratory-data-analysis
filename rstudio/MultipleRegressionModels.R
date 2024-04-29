library(tidyverse)
library(moderndive)
library(skimr)
library(ISLR)

# Load and explore the data set
evals_ch6 <- evals %>%
  select(ID, score, age, gender)

glimpse(evals_ch6)
evals_ch6 %>%
  sample_n(size = 5)
evals_ch6 %>%
  select(-ID) %>%
  skim()
evals_ch6 %>%
  get_correlation(score~age)

# Fit the model: one numerical and one categorical explanatory variables
# a>Interaction model
ggplot(evals_ch6, aes(x = age, y = score, color = gender)) +
  geom_point() +
  labs(x = "Age", y = "Teaching Score", color = "Gender") +
  geom_smooth(method = "lm", se = FALSE)

score_model_interaction <- lm(score ~ age * gender, data = evals_ch6)
get_regression_table(score_model_interaction)

interaction_model_regression_points <- get_regression_points(score_model_interaction)
interaction_model_regression_points

# b>Parallel slopes model
ggplot(evals_ch6, aes(x = age, y = score, color = gender)) +
  geom_point() +
  labs(x = "Age", y = "Teaching Score", color = "Gender") +
  geom_parallel_slopes(se = FALSE)

score_model_parallel <- lm(score ~ age + gender, data = evals_ch6)
get_regression_table(score_model_parallel)

parallel_model_regression_points <- get_regression_points(score_model_parallel)
parallel_model_regression_points

# Fit the model: two numerical explanatory variables
credit_ch6 <- Credit %>%
  as_tibble() %>%
  select(ID, debt = Balance, credit_limit = Limit, income = Income, credit_rating = Rating, age = Age)

glimpse(credit_ch6)
credit_ch6 %>%
  sample_n(size = 5)
credit_ch6 %>%
  select(debt, credit_limit, income) %>%
  skim()
credit_ch6 %>%
  get_correlation(debt ~ credit_limit)
credit_ch6 %>%
  get_correlation(debt ~ income)
credit_ch6 %>%
  select(debt, credit_limit, income) %>%
  cor()

ggplot(credit_ch6, aes(x = credit_limit, y = debt)) +
  geom_point() + 
  labs(x = "Credit Limit", y = "Credit Card Debt", title = "Credit Limit vs Credit Card Debt") +
  geom_smooth(method = "lm", se = FALSE)
ggplot(credit_ch6, aes(x = income, y = debt)) +
  geom_point() +
  labs(x = "Income", y = "Credit Card Debt", title = "Income vs Credit Card Debt") +
  geom_smooth(method = "lm", se = FALSE)

debt_model <- lm(debt ~ credit_limit + income, data = credit_ch6)
get_regression_table(debt_model)
get_regression_points(debt_model)

# Model selection using visualizations
glimpse(MA_schools)
# a>Interaction model
ggplot(MA_schools, aes(x = perc_disadvan, y = average_sat_math, color = size)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Percentage of Disadvantaged Students", y = "Average SAT Math Score", color = "School Size", title = "Interaction Model")
model_2_interaction <- lm(average_sat_math ~ perc_disadvan * size, data = MA_schools)
get_regression_table(model_2_interaction)

get_regression_points(model_2_interaction) %>%
  summarize(
    var_y = var(average_sat_math),
    var_yhat = var(average_sat_math_hat),
    var_residual = var(residual)
  )
get_regression_summaries(model_2_interaction)

# b>Parallel slopes model
ggplot(MA_schools, aes(x = perc_disadvan, y = average_sat_math, color = size)) +
  geom_point(alpha = 0.25) +
  geom_parallel_slopes(se = FALSE) +
  labs(x = "Percentage of Disadvantaged Students", y = "Average SAT Math Score", color = "School Size", title = "Parallel Slopes Model")
model_2_parallel <- lm(average_sat_math ~ perc_disadvan + size, data = MA_schools)
get_regression_table(model_2_parallel)

get_regression_points(model_2_parallel) %>%
  summarize(
    var_y = var(average_sat_math),
    var_yhat = var(average_sat_math_hat),
    var_residual = var(residual)
  )
get_regression_summaries(model_2_parallel)
