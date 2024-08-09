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
      version = "0.94.1"
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


provider "snowflake" {
  account   = var.snowflake_account
  user      = var.snowflake_user
  password  = var.snowflake_user_password
  role      = var.snowflake_user_role
}

resource "snowflake_schema" "test_schema" {
  name     = "test_schema"
  database = "db"
}


