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
ggplot(evals_ch6, aes(x = age, y = score, color = gender)) +
  geom_point() +
  labs(x = "Age", y = "Teaching Score", color = "Gender") +
  geom_smooth(method = "lm", se = FALSE)

# Fit the model: one numerical and one categorical explanatory variables
score_model_interaction <- lm(score ~ age * gender, data = evals_ch6)
get_regression_table(score_model_interaction)
