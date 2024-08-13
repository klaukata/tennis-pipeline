output "s3_bucket_prefix" {
    description = "A prefix of our raw data bucket"
    value = var.s3_prefix
}

output "itegration_description" {
  description = "The SnowSQL query result from the read statements."
  value = jsondecode(nonsensitive(snowsql_exec.read_integration_description.read_results))
}
