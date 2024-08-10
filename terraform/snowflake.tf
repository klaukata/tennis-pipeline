# creare a warehouse 
resource "snowflake_warehouse" "wh" {
  name = "most_recent_wh"
  comment = "A warehouse for our most recent file"
  warehouse_size = "x-small"
}
