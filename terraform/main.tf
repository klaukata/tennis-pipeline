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
      source  = "aidanmelen/snowsql"
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

provider "snowsql" {
  account   = var.snowflake_account
  username  = var.snowflake_user
  password  = var.snowflake_user_password
  role      = "CUSTOMROLE"
}

# copy from an ext. stage to a table
resource "snowsql_exec" "copy_table" {
  create {
    statements = <<-EOF
      create role if not exists temprole;
      COPY INTO DB.RECENT."raw_table"
        from @DB.RECENT.STAGE
        file_format = (FORMAT_NAME = DB.RECENT.CSVFORMAT)
        on_error = "continue";
    EOF
  }
  delete {
    statements = "drop role if exists temprole"
  }  
}