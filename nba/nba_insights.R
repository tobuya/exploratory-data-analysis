setwd("/home/tobuya/Projects/data/DataLab/nba")
library(tidyverse)

# Read in the data
game_stats <- read_csv("game_stats")
team_info <- read_csv("team_info")

# Drop duplicate rows
game <- game_stats |>
  distinct()

# View the data sets
View(game)
View(team_info)

# Extract stats for home teams
home_stats <- game |>
  select(team_id_home, fgm_home:pts_home, season_type, season) |>
  group_by(team_id_home, season_type, season) |>
  filter(season_type == "Regular Season") |>
  summarise(across(fgm_home:pts_home, sum))
View(home_stats)

# Extract stats for away teams
away_stats <- game |>
  select(team_id_away, fgm_away:pts_away, season_type, season) |>
  group_by(team_id_away, season_type, season) |>
  filter(season_type == "Regular Season") |>
  summarise(across(fgm_away:pts_away, sum))
View(away_stats)

# Combine home and away stats
team_stats <- home_stats |>
  inner_join(away_stats, by= c("team_id_home" = "team_id_away", "season")) |>
  mutate(field_goals_made = fgm_home + fgm_away,
         field_goals_attempt = fga_home + fga_away,
         three_point_made = fg3m_home + fg3m_away,
         three_point_attempt = fg3a_home + fg3a_away,
         free_throws_made = ftm_home + ftm_away,
         free_throws_attempt = fta_home + fta_away,
         offensive_rebounds = oreb_home + oreb_away,
         defensive_rebounds = dreb_home + dreb_away,
         total_rebounds = reb_home + reb_away,
         assists = ast_home + ast_away,
         steals = stl_home + stl_away,
         blocks = blk_home + blk_away,
         turnovers = tov_home + tov_away,
         personal_fouls = pf_home + pf_away,
         points = pts_home + pts_away) |>
  select(team_id = team_id_home, season, field_goals_made:points)
View(team_stats)

# Top 5 teams with the most the most overall points
top_6_teams <- team_stats |>
  group_by(team_id) |>
  summarise(total_points = sum(points)) |>
  arrange(desc(total_points)) |>
  head(6)
View(top_6_teams) 

# Stats for the top 5 teams
top_6_teams_stats <- team_stats |>
  filter(team_id %in% top_6_teams$team_id) |>
  group_by(team_id) |>
  summarize(across(field_goals_made:points, sum))
View(top_6_teams_stats)

# Merge team stats with team info
top_6_teams_data <- team_info |>
  inner_join(top_6_teams_stats, by = "team_id") |>
  select(team_name, field_goals_made:points, city, state, year_founded)
View(top_6_teams_data)
