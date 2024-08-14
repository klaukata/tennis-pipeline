# ____________WAREHOUSE____________
resource "snowflake_warehouse" "wh" {
  name = "project_wh"
  warehouse_size = "x-small"
}

#____________DATABASE____________
resource "snowflake_database" "goats" {
  name = "goats"
  comment = "A database containing both recent and historical versions of a GOAT data"
}

#____________SCHEMAS____________
resource "snowflake_schema" "recent" {
  name = "recent_schema"
  database = "goats"
}

resource "snowflake_schema" "historical" {
  name = "historical_schema"
  database = "goats"
}

#____________ROLE____________