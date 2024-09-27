with most_frequent_points as (
    select
        count(player_key) as n,
        goat_pts as g
    from {{ ref('dim_goat_table') }}
    group by g
    order by n desc
),

basic_stats as (
    select
        -- min, max & range
        min(goat_pts) as min,
        max(goat_pts) as max,
        (max - min) as range,
        -- avg
        round(avg(goat_pts::float), 2) as avg,
        -- modal
        (select n from most_frequent_points limit 1) as modal,
        -- standard deviation
        round(stddev(goat_pts), 2) as std_dev
    from {{ ref('dim_goat_table') }}
    
),

determine_quantiles as (
    select 
        player_key,
        goat_pts,
        ntile(4) over (order by goat_pts) as quantile
    from {{ ref('dim_goat_table') }}
),

quantiles as (
    select
        max(case when quantile = 1 then goat_pts end) as q1,
        max(case when quantile = 2 then goat_pts end) as median,
        max(case when quantile = 3 then goat_pts end) as q3
    from determine_quantiles
)

select *
from basic_stats b
cross join quantiles q
