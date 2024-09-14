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
    snowsql = {
      source = "aidanmelen/snowsql"
      version = "1.3.3"
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

provider "snowsql" {
  account   = var.snowflake_account
  username  = var.snowflake_user
  password  = var.snowflake_user_password
  role      = var.snowflake_user_role
}