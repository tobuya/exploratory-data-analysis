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
#~ Fit the regression model
score_model <- lm(score ~ bty_avg, data = evals_ch5)
#~ Get the regression table
get_regression_table(score_model)

regression_points <- get_regression_points(score_model)
regression_points
#~ Compute the sum of square residuals
regression_points %>%
  mutate(squared_residuals = residual^2) %>%
  summarize(sum_of_squared_residuals = sum(squared_residuals))

#Exploring the Gap minder data set
gapminder2007 <- gapminder %>%
  filter(year == 2007) %>%
  select(country, lifeExp, continent, gdpPercap)

glimpse(gapminder2007)
gapminder2007 %>%
  sample_n(size = 5)
gapminder2007 %>%
  select(lifeExp, continent) %>%
  skim()

ggplot(gapminder2007, aes(x = lifeExp)) +
  geom_histogram(binwidth = 5, color = "white") +
  labs(
    x = "Life expectancy", y = "Number of countries",
    title = "Histogram of life expectancy in 2007") +
  facet_wrap(~continent, nrow = 2)

ggplot(gapminder2007, aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  labs(x = "Continent", y = "Life Expecatancy", title = "Life Expectancy by continent in 2007")

lifeExp_by_continent <- gapminder2007 %>%
  group_by(continent) %>%
  summarize(median = median(lifeExp), mean = mean(lifeExp))
lifeExp_by_continent

#Linear Regression: Numerical and Categorical explanatory variable
lifeExp_model <- lm(lifeExp ~ continent, data = gapminder2007)
get_regression_table(lifeExp_model)
regression_points <- get_regression_points(lifeExp_model, ID = "country")
regression_points
