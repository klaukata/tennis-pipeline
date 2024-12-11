# ____________VARS AND LOCALS____________
variable "bucket_name" {
  type        = string
  description = "Name for our S3 bucket"
}

locals {
  bucket_arn    = aws_s3_bucket.raw_data.arn
  role_arn      = "arn:aws:iam::${local.account_id}:root"
  account_id    = data.aws_caller_identity.current.account_id
  iam_role_name = "snowflake_uploader"
}

# TODO: do i need this?
variable "snowflake_user_role" {
  type        = string
  description = "The role of the Terraform user"
  default     = "ACCOUNTADMIN"
}
# ____________OUTPUTS____________


output "iam_role_name_id" {
  value = aws_iam_role.snowflake.id
}

output "role_arn" {
  value = aws_iam_role.snowflake.arn
}

output "bucket_url" {
  value = "s3://${var.bucket_name}/"
}
