select
    "Index"::integer as player_key,
    replace(O, '-', 0)::integer as olympic_titles_num
from {{ source("raw_source", "raw_table") }}