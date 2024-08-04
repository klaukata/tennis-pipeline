resource "aws_s3_bucket" "bronze_data" {
    bucket_prefix = var.s3_prefix
  
}