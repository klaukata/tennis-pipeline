module "m_01_s3" {
  source    = "./01_s3"
  s3_prefix = var.s3_prefix
}

module "m_02_aws" {
  source      = "./02_aws"
  bucket_name = local.bucket_name
}

module "m_03_sf_aws" {
    depends_on = [module.m_02_aws] #TODO 
    source = "./03_sf_aws"
    account_id = module.m_02_aws.account_id
    role_name = module.m_02_aws.aws_role_name
    bucket_name = local.bucket_name
}