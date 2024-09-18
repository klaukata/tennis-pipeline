# ____________WAREHOUSE____________
resource "snowflake_warehouse" "wh" {
    name = "WH"
    warehouse_size = "small"
}


# ____________CUSTOM ROLE____________
# initial creation
resource "snowflake_account_role" "role" {
  name = "CUSTOMROLE"
}

# SYSADMIN role as a child
resource "snowflake_grant_account_role" "sysadmin_grant" {
  role_name = "SYSADMIN"
  parent_role_name = snowflake_account_role.role.name
}

# schema-level grant
resource "snowflake_grant_privileges_to_account_role" "schema_grant" {
  account_role_name = snowflake_account_role.role.name
  privileges = [ "CREATE STAGE" ]
  on_schema {
    all_schemas_in_database = "DB"
  }
}

# account-level grant
resource "snowflake_grant_privileges_to_account_role" "account_grant" {
  account_role_name = snowflake_account_role.role.name
  privileges = [ "CREATE ROLE", "CREATE INTEGRATION" ]
  on_account = true
}

# usage on a warehouse grant
resource "snowflake_grant_privileges_to_account_role" "name" {
  depends_on = [ snowflake_warehouse.wh ]
  account_role_name = snowflake_account_role.role.name
  privileges = [ "USAGE" ]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = "WH"
  }
}

# ACCOUNTADMIN role as a parent
resource "snowflake_grant_account_role" "user_grant" {
  role_name = snowflake_account_role.role.name
  parent_role_name = "ACCOUNTADMIN"
}
