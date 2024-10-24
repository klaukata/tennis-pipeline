resource "snowflake_storage_integration" "integration" {
  name                      = "STORAGE"
  type                      = "EXTERNAL_STAGE"
  storage_provider          = "S3"
  enabled                   = true
  storage_aws_role_arn      = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  storage_allowed_locations = ["s3://${var.bucket_name}/"]
}

# read a description of this integration
resource "snowsql_exec" "read_integration_description" {
  depends_on = [
    snowflake_storage_integration.integration
  ]
  create {
    statements = "CREATE ROLE if not exists temprole"
  }

  read {
    statements = <<-EOF
        desc integration "STORAGE"
      EOF
  }

  delete {
    statements = "DROP ROLE IF EXISTS temprole"
  }
}

# external stage
resource "snowflake_stage" "stage" {
  depends_on = [
    snowsql_exec.read_integration_description
  ]
  name                = "STAGE"
  database            = "DB"
  schema              = "RECENT"
  file_format         = "FORMAT_NAME = ${local.format_full_path}"
  storage_integration = snowflake_storage_integration.integration.name
  url                 = "s3://${var.bucket_name}/"
}
