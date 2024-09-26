select
    "Index"::integer as player_key,
    replace(O, '-', 0)::integer as olym
from {{ source("raw_source", "raw_table") }}