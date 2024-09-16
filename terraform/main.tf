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
  role      = snowflake_account_role.role.name
}

# custom role creation
resource "snowflake_account_role" "role" {
  name = "CUSTOMROLE"
}

resource "snowflake_grant_account_role" "sysadmin_grant" {
  role_name = "SYSADMIN"
  parent_role_name = snowflake_account_role.role.name
}


resource "snowflake_grant_privileges_to_account_role" "schema_grant" {
  account_role_name = snowflake_account_role.role.name
  privileges = [ "CREATE STAGE" ]
  on_schema {
    all_schemas_in_database = "DB"
  }
}

resource "snowflake_grant_privileges_to_account_role" "account_grant" {
  account_role_name = snowflake_account_role.role.name
  privileges = [ "MANAGE GRANTS", "CREATE INTEGRATION" ]
  on_account = true
}

resource "snowflake_grant_account_role" "user_grant" {
  role_name = snowflake_account_role.role.name
  parent_role_name = "ACCOUNTADMIN"
}

# copy from an ext. stange to a table
# resource "snowsql_exec" "copy_table" {
#   depends_on = [ snowflake_stage.stage ]
#   create {
#     statements = "create role if not exists temprole"
#   }
#   read {
#     statements = <<-EOF
#       COPY INTO ${snowflake_table.raw.name}
#         from @${snowflake_stage.stage.name}
#         file_format = (FORMAT_NAME = "${local.format_full_path}")
#         on_error = "continue"
#     EOF
#   }
#   delete {
#     statements = "drop role if exists temprole"
#   }  
# }