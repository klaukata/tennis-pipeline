select 
    player_key,
    {{ calc_ratio('gs_pts', 'big_title_pts') }} as gs_bt_ratio,
    {{ calc_ratio('gs_pts', 'all_titles_pts') }} as gs_t_ratio
from {{ ref("stg_clean_raw") }}