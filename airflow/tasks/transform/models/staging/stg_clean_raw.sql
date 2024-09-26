select 
    rn.player_key,
    rn.rank,
    rn.name,
    rn.goat_pts,
    rn.t_pts,
    rn.rank_pts,
    rn.ach_pts,
    rn.gs,
	rn.atp,
	rn.alt,
	rn.m,
    o.olym,
	rn.bt,
	rn.t,
	rn.no1_weeks,
    w.win_proc,
	rn.peak_elo
from {{ ref("stg_renamed") }} rn
join {{ ref("stg_w_proc_col") }} w on rn.player_key = w.player_key
join {{ ref("stg_o_col") }} o on rn.player_key = o.player_key
