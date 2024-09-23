select 
    "Index"::integer as player_key,
    replace("W%", '%', '')::float as win_proc
from {{ source("raw_source", "raw_table") }}