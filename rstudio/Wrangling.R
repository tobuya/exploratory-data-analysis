library(dplyr)
library(ggplot2)
library(nycflights13)

#Filter ~ a data frame existing rows to only to only pick up a subset of them.
btv_sea_flights_fall <- flights %>%
  filter(origin == "JFK", (dest == "BTV" | dest == "SEA"), month >= 10)
View(btv_sea_flights_fall)

not_BTV_SEA <- flights %>%
  filter(!(dest == "BTV" | dest == "SEA"))
View(not_BTV_SEA)

many_airports <- flights %>%
  filter(dest %in% c("SEA", "SFO", "PDX"))

#Summarize - one or more of its column/variables with a summary statistic.
summary_temp <- weather %>%
  summarize(mean = mean(temp, na.rm = TRUE), sd = sd(temp, na.rm = TRUE), count = n())
summary_temp

#Group_by ~ assign different rows to be part of the same group.
summary_monthly_temp <- weather %>%
  group_by(month) %>%
  summarize(mean = mean(temp, na.rm = TRUE), sd = sd(temp, na.rm = TRUE), count = n())
summary_monthly_temp
summary_price_carat_by_cut <- diamonds %>%
  group_by(cut) %>%
  summarize(avg_price = mean(price), avg_carat = mean(carat))
summary_price_carat_by_cut
by_origin <- flights %>%
  group_by(origin) %>%
  summarize(count = n())
by_origin
by_origin_monthly <- flights %>%
  group_by(origin, month) %>%
  summarize(count = n())
by_origin_monthly

#Mutate ~ create a new column/variable based on the existing ones.
weather <- weather %>%
  mutate(temp_in_c = (temp - 32) / 1.8)
summary_monthly_temp <- weather %>%
  group_by(month) %>%
  summarize(temp_in_F = mean(temp, na.rm = TRUE), temp_in_C = mean(temp_in_c, na.rm = TRUE))
summary_monthly_temp
flights <- flights %>%
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
    )
gained_summary <- flights %>%
  summarize(
    min = min(gain, na.rm = TRUE),
    q1 = quantile(gain, 0.25, na.rm = TRUE),
    median = median(gain, na.rm = TRUE),
    q3 = quantile(gain, 0.75, na.rm = TRUE),
    max = max(gain, na.rm = TRUE),
    mean = mean(gain, na.rm = TRUE),
    sd = sd(gain, na.rm = TRUE),
    missing = sum(is.na(gain))
  )
gained_summary
ggplot(flights, aes(x = gain)) + geom_histogram(color = "white", bins = 20)

#Select ~ pick up a subset of columns/variables.
flights <- flights %>%
  select(carrier, flights)
flights_no_year <- flights %>%
  select(-year)
flight_arr_time <- flights %>%
  select(month:day, arr_time:sched_arr_time)
flights_reorder <- flights %>%
  select(year, month, day, hour, minute, time_hour, everything())
flights %>%
  select(starts_with("a"))
flights %>%
  select(ends_with("delay"))
flights %>%
  select(contains("time"))
#Arrange ~ sort the rows of a data frame.
frequent_dest <- flights %>%
  group_by(dest) %>%
  summarize(num_flights = n())
frequent_dest %>%
  arrange(desc(num_flights))

#Join ~ merge two data frames based on a common column/variable.
flights_joined <- flights %>%
  inner_join(airlines, by = "carrier")
View(flights_joined)
# ~ Different key variables
flights_with_airports_name <- flights %>%
  inner_join(airports, by = c("dest" = "faa"))
View(flights_with_airports_name)
named_destinations <- flights %>%
  group_by(dest) %>%
  summarize(num_flights = n()) %>%
  arrange(desc(num_flights)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  rename(airport_name = name)
named_destinations
# ~ Multiple key variables
flights_weather_joined <- flights %>%
  inner_join(weather, by = c("year", "month", "day", "hour", "origin"))
View(flights_weather_joined)

# Top_n ~ select the top n rows based on a variable.
named_destinations %>%
  top_n(10, num_flights) %>%
  arrange(desc(num_flights))
