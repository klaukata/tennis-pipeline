variable "bucket_name" {
  type        = string
  description = "A name of a bucket where our raw data is stored"
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  role_name  = aws_iam_role.snowflake_uploader.name
}