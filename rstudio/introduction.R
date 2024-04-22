setwd("/home/tobuya/Projects/data/DataLab/rstudio")
library(dplyr)
library(nycflights13)
library(knitr)

# Exploring data frames
View(flights)
glimpse(flights)
kable(airlines)
airlines$name
