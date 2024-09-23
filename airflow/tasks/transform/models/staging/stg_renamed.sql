select 
    "Index"::integer as player_key,
    "Rank"::integer as rank,
    "Name" as name,
    "Pts"::integer as goat_pts,
    "Tourn P"::integer as tournament_pts,
	"Rank P"::integer as ranking_pts,
	"Ach P"::integer as achievement_pts,
	GS::integer as gs_pts,
	TF::integer as atp_pts,
	AF::integer as alternative_pts,
	M::integer as masters_pts,
	BT::integer as big_title_pts,
	T::integer as all_titles_pts,
	"W@1"::integer as no1_weeks,
	"Elo"::integer as peak_elo
from {{ source("raw_source", "raw_table") }}