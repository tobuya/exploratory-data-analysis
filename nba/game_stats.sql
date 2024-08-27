SELECT game.season_id, game.team_id_home, game.game_id, game.game_date, game.wl_home, game.fgm_home, game.fga_home,
	game.fg_pct_home, game.fg3m_home, game.fg3a_home, game.fg3_pct_home, game.ftm_home, game.fta_home, game.ft_pct_home,
	game.oreb_home, game.dreb_home, game.reb_home, game.ast_home, game.stl_home, game.blk_home, game.tov_home, game.pf_home,
	game.pts_home, game.team_id_away, game.wl_away, game.fgm_away, game.fga_away, game.fg_pct_away, game.fg3m_away, game.fg3a_away,
	game.fg3_pct_away, game.ftm_away, game.fta_away, game.ft_pct_away, game.oreb_away, game.dreb_away, game.reb_away, game.ast_away,
	game.stl_away, game.blk_away, game.tov_away, game.pf_away, game.pts_away, game.season_type, game_info.attendance, game_summary.season
FROM game
INNER JOIN game_info ON game.game_id = game_info.game_id
INNER JOIN game_summary ON game.game_id = game_summary.game_id
WHERE season >= 2010;