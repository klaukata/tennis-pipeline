# ____________WAREHOUSE____________
resource "snowflake_warehouse" "wh" {
  name = "PROJECT_WH"
  warehouse_size = "x-small"
}

#____________DATABASE____________
resource "snowflake_database" "goats" {
  name = "GOATS"
  comment = "A database containing both recent and historical versions of a GOAT data"
}
