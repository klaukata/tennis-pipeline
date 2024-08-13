# creare a warehouse 
resource "snowflake_warehouse" "wh" {
  name = "project_wh"
  comment = "A warehouse for our most recent file"
  warehouse_size = "x-small"
}

# create a storage integration w/ a bucket
resource "snowflake_storage_integration" "integration" {
  name = "storage"
  type = "EXTERNAL_STAGE"
  storage_provider = "S3"
  enabled = true
  storage_aws_role_arn = "arn:aws:iam::${local.account_id}:role/${local.role_name}"
  storage_allowed_locations = [ "s3://${local.bucket_name}/" ]
}

# read a description of this integration
resource "snowsql_exec" "read_integration_description" {
    create {
      statements = "CREATE ROLE if not exists my_role"
    }

    read {
      statements = "desc integration integ"
    }

    delete {
      statements = "DROP ROLE IF EXISTS my_role"
    }
}