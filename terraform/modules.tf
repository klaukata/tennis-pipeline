module "m_s3" {
  source    = "./m_s3"
  s3_prefix = var.s3_prefix
}

module "m_aws" {
  source      = "./m_aws"
  bucket_name = local.bucket_name
}

module "m_sf_aws" {
  source      = "./m_sf_aws"
  account_id  = module.m_aws.account_id
  role_name   = module.m_aws.role_name
  bucket_name = local.bucket_name
  snow_role   = "CUSTOMROLE"
}