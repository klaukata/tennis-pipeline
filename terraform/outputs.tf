output "s3_bucket_prefix" {
  description = "A prefix of our raw data bucket"
  value       = var.s3_prefix
}

output "aws_account_id" {
  value = module.m_02_aws.account_id
}

output "aws_role_name" {
  value = module.m_02_aws.role_name
}

# output "snowflake_itegration_description" {
#   value = module.m_03_sf_aws.itegration_description
# }