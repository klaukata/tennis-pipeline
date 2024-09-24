select 
    rn.player_key,
    rn.rank,
    rn.name,
    rn.goat_pts,
    rn.tournament_pts,
    rn.ranking_pts,
    rn.achievement_pts,
    rn.gs_pts,
	rn.atp_pts,
	rn.alternative_pts,
	rn.masters_pts,
    o.olympic_titles_num,
	rn.big_title_pts,
	rn.all_titles_pts,
	rn.no1_weeks,
    w.win_proc,
	rn.peak_elo
from {{ ref("stg_renamed") }} rn
join {{ ref("stg_w_proc_col") }} w on rn.player_key = w.player_key
join {{ ref("stg_o_col") }} o on rn.player_key = o.player_key
