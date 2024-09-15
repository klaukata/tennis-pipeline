terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    dotenv = {
      source = "jrhouston/dotenv"
      version = "~> 1.0"
    }
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.95.0"
    }
  }
}

# connecting to an aws acc
provider "aws" {}

# reading .env variables from a file '.env'
provider "dotenv" {}

data "dotenv" "dev_config" {
  filename = ".env"
}

# connecting to a snowflake acc
provider "snowflake" {
  account   = var.snowflake_account
  user      = var.snowflake_user
  password  = var.snowflake_user_password
  role      = var.snowflake_user_role
}

# custom role creation
resource "snowflake_account_role" "role" {
  name = "CUSTOMROLE"
}

resource "snowflake_grant_account_role" "role_grant" {
  role_name = "SYSADMIN"
  parent_role_name = snowflake_account_role.role.name
}

resource "snowflake_grant_privileges_to_account_role" "grant" {
  account_role_name = snowflake_account_role.role.name
  privileges = [ "USAGE" ]
  on_account_object {
    object_name = "storage"
    object_type = "INTEGRATION"
  }
}

resource "snowflake_grant_account_role" "user_grant" {
  role_name = snowflake_account_role.role.name
  parent_role_name = "ACCOUNTADMIN"
}