output "s3_bucket_prefix" {
  description = "A prefix of our raw data bucket"
  value       = var.s3_prefix
}

output "aws_account_id" {
  description = "An ID of an AWS account"
  value = module.m_aws.account_id
}

output "aws_role_name" {
  description = "Name of a IAM role"
  value = module.m_aws.role_name
}

output "snowflake_itegration_description" {
  value = module.m_sf_aws.itegration_description
}