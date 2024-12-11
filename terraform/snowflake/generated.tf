# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "snowflake_uploader"
resource "aws_iam_role" "snowflake" {
  assume_role_policy    = data.aws_iam_policy_document.iam_trust_policy.json
  description           = "Role that will upload the most recent .csv file to Snowflake"
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "snowflake_uploader"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
