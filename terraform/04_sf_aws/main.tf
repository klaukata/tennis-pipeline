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
  account   = var.snow_acc
  user      = var.snow_usr
  password  = var.snow_pass
  role      = var.snow_role
  warehouse = "WH"
}

provider "snowsql" {
  account   = var.snow_acc
  username  = var.snow_usr
  password  = var.snow_pass
  role      = var.snow_role
  warehouse = "WH"
}