terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.95.0"
    }
    snowsql = {
      source  = "aidanmelen/snowsql"
      version = "1.3.3"
    }
  }
}

provider "snowflake" {
  role      = var.snow_role
  warehouse = "WH"
}

provider "snowsql" {
  role      = var.snow_role
  warehouse = "WH"
}