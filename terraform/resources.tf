# ____________BUCKET____________
resource "aws_s3_bucket" "raw_data" {
  bucket = var.s3_name
}

# ____________TRUST POLICY____________

# data source for an access to authorized account id
data "aws_caller_identity" "current" {}

# trust policy = who can assume the 'snowflake_uploader' role
data "aws_iam_policy_document" "iam_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }
}

# ____________CLOUDWATCH ALARM____________
resource "aws_cloudwatch_metric_alarm" "size_alarm" {
  depends_on = [ aws_s3_bucket.raw_data ]
  alarm_name        = "bucket_size_alarm"
  alarm_description = "Alarm when S3 bucket size exceeds "
  namespace         = "AWS/S3"
  metric_name       = "BucketSizeBytes"
  dimensions = {
    StorageType = "StandardStorage"
    BucketName  = var.s3_name
  }
  statistic           = "Maximum"
  period              = 86400 # 1 day
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 50000 # 50kB
  evaluation_periods  = 1     # condition must be met 1 time for an alarm to go off
  alarm_actions       = [aws_sns_topic.size_reached.arn]
}

# ____________SNS TOPIC____________
resource "aws_sns_topic" "size_reached" {
  name = "bucket_size_topic"
}

resource "aws_sns_topic_subscription" "size_reached_subsciption" {
  topic_arn = aws_sns_topic.size_reached.arn
  protocol  = "email"
  endpoint  = "kkborowy@gmail.com" #TODO - custom
}

# ____________CREATING A ROLE____________
# resource that creates a role
resource "aws_iam_role" "snowflake_uploader" {
  depends_on         = [aws_cloudwatch_metric_alarm.size_alarm]
  name               = "snowflake_uploader"
  description        = "Role that will upload the most recent .csv file to Snowflake"
  assume_role_policy = data.aws_iam_policy_document.iam_trust_policy.json
}

# ____________PERMISSIONS POLICY____________
# permissions policy = what can 'snowflake_uploader' role do
data "aws_iam_policy_document" "iam_permissions_policy" {
  statement {
    actions = [
      "s3:GetObject",   # retrieve objects from a bucket
      "s3:PutObject",   # add an obj to a bucket
      "s3:DeleteObject" # rm a null version 
    ]
    resources = ["arn:aws:s3:::${var.s3_name}/*"]
  }
  statement {
    actions = [
      "s3:ListBucket",       # lists objects in a bucket
      "s3:GetBucketLocation" # returns an s3 region
    ]
    resources = ["arn:aws:s3:::${var.s3_name}"]
  }
}

# append permissions policy to 'snowflake_uploader' role
resource "aws_iam_role_policy" "iam_add_perm_policy" {
  depends_on = [aws_iam_role.snowflake_uploader]
  name       = "iam_add_perm_policy"
  role       = aws_iam_role.snowflake_uploader.id
  policy     = data.aws_iam_policy_document.iam_permissions_policy.json
}