module "m_01_s3" {
  source    = "./01_s3"
  s3_prefix = var.s3_prefix
}

module "m_02_aws" {
  source      = "./02_aws"
  bucket_name = local.bucket_name
}

module "m_03_sf_aws" {
    # depends_on = [module.m_02_aws] #TODO 
    source = "./03_sf_aws"
    account_id = module.m_02_aws.account_id
    role_name = module.m_02_aws.role_name
    bucket_name = local.bucket_name

    # variable values defined in secret-variables.tf file
    snow_acc = var.snowflake_account
    snow_usr = var.snowflake_user
    snow_pass = var.snowflake_user_password
    snow_role = snowflake_account_role.role.name
}