select 
    player_key,
    {{ calc_ratio('gs', 'bt') }} as gs_bt_ratio,
    {{ calc_ratio('gs', 't') }} as gs_t_ratio
from {{ ref("stg_clean_raw") }}