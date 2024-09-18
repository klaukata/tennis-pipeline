terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.95.0"
    }
  }
}

provider "snowflake" {
  account  = var.snow_acc
  user     = var.snow_usr
  password = var.snow_pass
  role     = var.snow_role
}