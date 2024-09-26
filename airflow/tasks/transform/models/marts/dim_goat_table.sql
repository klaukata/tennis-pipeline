with staging_data as (
    select 
        c.*,
        r.GS_BT_RATIO,
        r.GS_T_RATIO,
        d.GOAT_DEVIATION
    from {{ ref('stg_clean_raw') }} c
    join {{ ref('int_ratios') }} r on r.player_key = c.player_key
    join {{ ref('int_goat_pts_deviation') }} d on d.player_key = c.player_key
)   

select *
from staging_data