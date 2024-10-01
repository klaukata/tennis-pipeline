select 
    bt,
    (gs + atp + alt + m + o) as sum_bt
from {{ ref('dim_goat_table') }}
where bt != sum_bt