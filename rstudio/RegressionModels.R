library(tidyverse)
library(moderndive)
library(skimr)
library(gapminder)

evals_ch5 <- evals %>%
  select(ID, score, bty_avg, age)

# Exploring the data
glimpse(evals_ch5)
evals_ch5 %>%
  sample_n(size = 5)
evals_ch5 %>%
  summarize(
    mean_bty_avg = mean(bty_avg),
    mean_score = mean(score),
    median_bty_avg = median(bty_avg),
    median_score = median(score))
evals_ch5 %>%
  select(bty_avg, score) %>%
  skim()

evals_ch5 %>%
  get_correlation(formula = score~bty_avg)
evals_ch5 %>%
  summarize(correlation = cor(score, bty_avg))

ggplot(evals_ch5, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "Beauty score", y = "Teaching score", title = "Scatter plot of teaching score vs beauty score") +
  geom_smooth(method = "lm", se = FALSE)

#Simple Linear Regression
