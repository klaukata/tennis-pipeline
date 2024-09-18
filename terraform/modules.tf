module "m_s3" {
  source    = "./01_s3"
  s3_prefix = var.s3_prefix
}

module "m_aws" {
  source      = "./02_aws"
  bucket_name = local.bucket_name
}

module "m_sf_setup" {
  source = "./03_sf_setup"
  snow_acc = var.snowflake_account
  snow_usr = var.snowflake_user
  snow_pass = var.snowflake_user_password
  snow_role = "ACCOUNTADMIN"
}

module "m_sf_aws" {
    source = "./04_sf_aws"
    account_id = module.m_aws.account_id
    role_name = module.m_aws.role_name
    bucket_name = local.bucket_name
    snow_acc = var.snowflake_account
    snow_usr = var.snowflake_user
    snow_pass = var.snowflake_user_password
    snow_role = "CUSTOMROLE"
}