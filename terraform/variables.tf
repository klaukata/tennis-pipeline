# ____________VARS AND LOCALS____________
variable "bucket_name" {
  type        = string
  description = "Name for our S3 bucket"
}

variable "snowflake_user_role" {
  type        = string
  description = "The role of the Terraform user"
  default     = "ACCOUNTADMIN"
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  iam_role_name = "snowflake_uploader"
}

# ____________OUTPUTS____________


output "account_id" {
  value = local.account_id
}

output "iam_role_name" {
  value = local.iam_role_name
}