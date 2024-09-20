# ____________BUCKET____________
resource "aws_s3_bucket" "raw_data" {
  bucket_prefix = var.s3_prefix
}