select 
    player_key,
    {{ calculate_ratio('gs_pts', 'big_title_pts') }} as gs_bt_ratio,
    {{ calculate_ratio('gs_pts', 'all_titles_pts') }} as gs_t_ratio
from {{ ref("stg_clean_raw") }}