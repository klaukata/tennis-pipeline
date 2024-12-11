terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.98.0"
    }
  }
}
provider "aws" {}

provider "snowflake" {}

# remote state
data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../terraform.tfstate"
  }
}

# storage integration
resource "snowflake_storage_integration" "integ" {
  name                      = "integ"
  type                      = "EXTERNAL_STAGE"
  enabled                   = true
  storage_provider          = "S3"
  storage_aws_role_arn      = data.terraform_remote_state.base.outputs.role_arn
  storage_allowed_locations = ["${data.terraform_remote_state.base.outputs.bucket_url}"]
}

resource "snowflake_stage" "stage" {
  name                = "stage"
  database            = "DB"
  schema              = "RECENT"
  file_format         = "FORMAT_NAME = DB.RECENT.CSVFORMAT"
  storage_integration = snowflake_storage_integration.integ.name
  url                 = data.terraform_remote_state.base.outputs.bucket_url
}