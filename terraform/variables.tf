variable "s3_prefix" {
  type        = string
  description = "Bucket prefix for our S3 bucket"
  default     = "pipeline-bucket-"
}

locals {
  bucket_name = data.dotenv.dev_config.env.BUCKET_NAME
}