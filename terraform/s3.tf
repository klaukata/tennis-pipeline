resource "aws_s3_bucket" "bronze-data" {
    bucket_prefix = var.s3-prefix
  
}