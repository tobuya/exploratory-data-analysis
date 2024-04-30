library(tidyverse)
library(moderndive)

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

