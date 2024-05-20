library(nycflights13)
library(tidyverse)
library(moderndive)
library(palmerpenguins)
library(ggthemes)

#SCATTER PLOTS ~ relationship between two numerical variables
ggplot(alaska_flights, aes(x = dep_delay, y = arr_delay)) + geom_point()
#Dealing with over plotting: Adjust transparency of points or use jitter
ggplot(alaska_flights, aes(x = dep_delay, y = arr_delay)) + 
  geom_point(alpha = 0.2)
ggplot(alaska_flights, aes(x = dep_delay, y = arr_delay)) +
  geom_jitter(width = 35, height = 35)

#R4DS Scatter plots
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species",
    caption = "Data come from the palmerpenguins package"
  ) +
  scale_color_colorblind()


#Line graphs - relationship between two numerical variables, x-axis is ordered.
ggplot(early_january_weather, aes(x = time_hour, y = temp)) + geom_line()

#Histograms - visualize the distribution of a single numerical variable
ggplot(weather, aes(x = temp)) + geom_histogram(bins = 10, color = "white")
ggplot(weather, aes(x = temp)) + geom_histogram(binwidth = 15, color = "white")
ggplot(weather, aes( x = temp)) +
  geom_histogram(binwidth = 10, color = "white") +
  facet_wrap(~month, nrow = 4)

#Box plots - visualize the distribution of a numerical variable by a categorical variable
ggplot(weather, aes(x = factor(month), y = temp)) + geom_boxplot()
ggplot(weather, aes(x = factor(month), y = temp)) + geom_boxplot() + coord_flip()

# Bar plots - visualize the distribution of a categorical variable
fruits <- tibble(
  fruit = c("apple", "apple", "grapes", "apple", "grapes")
)

fruits_counted <- tibble(
  fruit = c("apple", "grapes"),
  count = c(3, 2)
)

ggplot(fruits, aes(x = fruit)) + geom_bar()
ggplot(fruits_counted, aes(x = fruit, y = count)) + geom_col()
ggplot(flights, aes(x = carrier)) + geom_bar()

flights_counted <- tibble(
  carrier = c("AA", "AS", "B6", "DL", "EV", "F9", "HA", "MQ", "OO", "UA", "US", "VX", "WN"),
  count = c(32729, 714, 54635, 48110, 54173, 685, 342, 26397, 32, 58665, 20536, 5116, 12275)
)
ggplot(flights_counted, aes(x = carrier, y = count)) + geom_col()
#Two categorical variables
ggplot(flights, aes(x = carrier, fill = origin)) + geom_bar()
ggplot(flights, aes(x = carrier, fill = origin)) + 
  geom_bar(position = position_dodge(preserve = "single"))
ggplot(flights, aes(x = carrier)) + geom_bar() +
  facet_wrap(~origin, ncol = 1)
