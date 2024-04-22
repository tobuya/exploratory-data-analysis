setwd("/home/tobuya/Projects/rstudio/learn")
library(dplyr)
library(nycflights13)
library(knitr)

# Exploring data frames
View(flights)
glimpse(flights)
kable(airlines)
airlines$name
