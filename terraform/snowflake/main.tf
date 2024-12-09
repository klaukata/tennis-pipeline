terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.98.0"
    }
  }
}
provider "aws" {}

provider "snowflake" {
    # TODO: switch to use a profile arguement
    organization_name = local.organization_name
    account_name  = var.account_name
    user     = local.user
    password = local.password
    role     = local.role
}

# remote state
data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../terraform.tfstate"
  }
}

# storage integration definition
resource "snowflake_storage_integration" "integ" {
  name = "integ"
  type = "EXTERNAL_STAGE"
  enabled = true
  storage_provider = "S3"
  storage_aws_role_arn = data.terraform_remote_state.base.outputs.role_arn
  storage_allowed_locations = [ "${data.terraform_remote_state.base.outputs.bucket_url}" ]
}