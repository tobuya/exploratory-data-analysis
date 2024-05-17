library(tidyverse)
library(moderndive)
library(infer)

# Virtual sampling
virtual_samples <- bowl %>%
  rep_sample_n(size = 50, reps = 1000)

virtual_prop_red <- virtual_samples %>%
  group_by(replicate) %>%
  summarize(red = sum(color == "red")) %>%
  mutate(prop_red = red / 50)
virtual_prop_red

ggplot(virtual_prop_red, aes(x = prop_red)) +
  geom_histogram(binwidth = 0.05, boundary = 0.4, color = "white") +
  labs(x = "Proportion of 50 balls that are red", title = "Distribution of 1000 proportions red")

# Bootstrapping and Confidence Interval
ggplot(pennies_sample, aes(x = year)) + 
  geom_histogram(binwidth = 10, color = "white") +
  labs(title = "Original sample of 50 pennies")
x_bar <- pennies_sample %>%
  summarize(mean_year = mean(year))
x_bar

ggplot(pennies_resamples, aes(x = year)) +
  geom_histogram(binwidth = 10, color = "white") +
  labs(title = "Resample of 50 pennies")
resampled_means <- pennies_resamples %>%
  group_by(name) %>%
  summarize(mean_year = mean(year))
resampled_means
ggplot(resampled_means, aes(x = mean_year)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1990) +
  labs(x = "Sampled mean year")

virtual_resample <- pennies_sample %>%
  rep_sample_n(size = 50, replace = TRUE)
virtual_resample %>%
  summarize(mean_year = mean(year))

virtual_resample_means <- pennies_sample %>%
  rep_sample_n(size = 50, replace = TRUE, reps = 1000) %>%
  group_by(replicate) %>%
  summarize(mean_year = mean(year))
virtual_resample_means
ggplot(virtual_resample_means, aes(x = mean_year)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1990) +
  labs(x = "sample mean")
virtual_resample_means %>%
  summarize(mean_of_means = mean(mean_year))

# Infer workflow
bootstrap_dist <- pennies_sample %>%
  specify(response = year) %>%
  generate(reps = 1000) %>%
  calculate(stat = "mean")
visualize(bootstrap_dist) +
  labs(title = "Bootstrap distribution of the sample mean year")
