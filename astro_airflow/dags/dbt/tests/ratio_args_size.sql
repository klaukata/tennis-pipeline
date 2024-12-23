select *
from {{ ref('dim_goat_table') }}
where gs > bt or bt > t