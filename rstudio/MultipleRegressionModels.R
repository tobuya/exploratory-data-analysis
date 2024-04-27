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
