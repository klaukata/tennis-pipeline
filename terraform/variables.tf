variable "s3_prefix" {
  type = string
  description = "Bucket prefix for our S3 bucket"
  default = "pipeline-bucket-"
}

locals {
  bucket_name = data.dotenv.dev_config.env.BUCKET_NAME
  account_id = data.aws_caller_identity.current.account_id
  role_name = aws_iam_role.snowflake_uploader.name
}