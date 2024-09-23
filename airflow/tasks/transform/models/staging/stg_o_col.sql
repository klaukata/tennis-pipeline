select
    "Index"::integer as player_key,
    replace(O, '-', '0') as olympic_titles_num
from {{ source("raw_source", "raw_table") }}