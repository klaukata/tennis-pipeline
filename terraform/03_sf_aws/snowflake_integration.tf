resource "snowflake_storage_integration" "integration" {
  name = "storage"
  type = "EXTERNAL_STAGE"
  storage_provider = "S3"
  enabled = true
  storage_aws_role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  storage_allowed_locations = [ "s3://${var.bucket_name}/" ]
}

# read a description of this integration
resource "snowsql_exec" "read_integration_description" {
  depends_on = [ snowflake_storage_integration.integration ]
    create {
      statements = "CREATE ROLE if not exists my_role"
    }

    read {
      statements = <<-EOF
        desc integration "storage"
      EOF
    }

    delete {
      statements = "DROP ROLE IF EXISTS my_role"
    }
}