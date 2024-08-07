variable "s3_prefix" {
  type = string
  description = "Bucket prefix for our S3 bucket"
  default = "pipeline-bucket-"
}

variable "bucket_name" {
  type = string
  description = "Full name of our bucket that in necessary for a CloudWatch alarm"
  default = data.dotenv.dev_config.env.BUCKET_NAME
}