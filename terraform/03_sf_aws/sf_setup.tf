resource "snowflake_database" "db" {
    name = "DB"
    comment = "A database for recent and previous tables"
}

resource "snowflake_schema" "recent_schema" {
    name = "RECENT"
    database = snowflake_database.db.name
}

resource "snowflake_schema" "previous_schema" {
    name = "PREVIOUS"
    database = snowflake_database.db.name
}

resource "snowflake_table" "raw" {
    database = snowflake_database.db.name
    schema = snowflake_schema.recent_schema.name
    name = "raw_table"
    column {
      name = "raw_object"
      type = "VARIANT"
    }
    lifecycle {
      create_before_destroy = true # == create or replace
    }
}

resource "snowflake_file_format" "format" {
    name = "CSVFORMAT" 
    database = snowflake_database.db.name
    schema = snowflake_schema.recent_schema.name
    format_type = "CSV"
    field_delimiter = ","
}

