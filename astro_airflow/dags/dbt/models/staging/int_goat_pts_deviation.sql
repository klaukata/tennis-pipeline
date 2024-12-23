with base as (
    select 
        player_key,
        goat_pts::float as goat_pts
    from {{ ref("stg_clean_raw") }}
),

avg as (
    select
        avg(goat_pts) as avg
    from base
),

deviation as (
    select
        b.player_key,
        (b.goat_pts - a.avg) as goat_deviation
    from base b
    cross join avg a
)

select 
    player_key,
    ROUND(goat_deviation, 2) as goat_deviation
from deviation