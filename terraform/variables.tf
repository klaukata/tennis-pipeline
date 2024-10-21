variable "s3_name" {
  type        = string
  description = "Bucket prefix for our S3 bucket"
  default     = "pipeline-bucket"
}

variable "snowflake_user_role" {
  type        = string
  description = "The role of the Terraform user"
  default     = "ACCOUNTADMIN"
}

locals {
  account_id = data.aws_caller_identity.current.account_id
}