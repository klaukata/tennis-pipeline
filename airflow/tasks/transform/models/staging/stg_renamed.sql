select 
    "Index"::integer as player_key,
    "Rank"::integer as rank,
    "Name" as name,
    "Pts"::integer as goat_pts,
    "Tourn P"::integer as t_pts,
	"Rank P"::integer as rank_pts,
	"Ach P"::integer as ach_pts,
	GS::integer as gs,
	TF::integer as atp,
	AF::integer as alt,
	M::integer as m,
	BT::integer as bt,
	T::integer as t,
	"W@1"::integer as no1_weeks,
	"Elo"::integer as peak_elo
from {{ source("raw_source", "raw_table") }}