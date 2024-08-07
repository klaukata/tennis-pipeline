resource "aws_s3_bucket" "raw_data" {
    bucket_prefix = var.s3_prefix
}

resource "aws_cloudwatch_metric_alarm" "size_alarm" {
    alarm_name =    "dfsd"
    alarm_description = "Alarm when S3 bucket size exceeds "
    namespace =     "AWS/S3"
    metric_name =  "BucketSizeBytes"
    dimensions = {
        StorageType = "StandardStorage"
        BucketName = local.bucket_name
    }
    statistic = "Maximum"
    period = 86400 # 1 day
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold = 50000 # 50kB
    evaluation_periods = 1 # condition must be met 1 time for an alarm to go off
    alarm_actions = [  ]
}

