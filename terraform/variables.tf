variable "s3_prefix" {
  type        = string
  description = "Bucket prefix for our S3 bucket"
  default     = "pipeline-bucket-"
}

variable "snowflake_user_role" {
  description = "The role of the Terraform user"
  type        = string
  default     = "ACCOUNTADMIN"
}

locals {
  bucket_name = data.dotenv.dev_config.env.BUCKET_NAME
}