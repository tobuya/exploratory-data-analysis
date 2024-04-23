library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(nycflights13)
library(fivethirtyeight)

dem_score <- read_csv("https://moderndive.com/data/dem_score.csv")

drinks_smaller <- drinks %>%
  filter(country %in% c("USA", "China", "Italy", "Saudi Arabia", "Kenya")) %>%
  select(-total_litres_of_pure_alcohol) %>%
  rename(beer = beer_servings, spirit = spirit_servings, wine = wine_servings)
drinks_smaller

drinks_smaller_tidy <- drinks_smaller %>%
  pivot_longer(names_to = "type", values_to = "servings", cols = -country)
drinks_smaller_tidy

drinks_smaller %>% 
  pivot_longer(names_to = "type", 
               values_to = "servings", 
               cols = c(beer, spirit, wine))

ggplot(drinks_smaller_tidy, aes(x = country, y = servings, fill = type)) +
  geom_col(position = "dodge")

guat_dem_score <- dem_score %>%
  filter( country == "Guatemala")
guat_dem_score
guat_dem_score_tidy <- guat_dem_score %>%
  pivot_longer(
    names_to = "years",
    values_to = "democracy_scores",
    cols = -country,
    names_transform = list(years = as.integer))
guat_dem_score_tidy

ggplot(guat_dem_score_tidy, aes(x = years, y = democracy_scores)) +
  geom_line() + 
  labs(x = "Years", y = "Democracy Scores", title = "Democracy Scores in Guatemala Over Time")
