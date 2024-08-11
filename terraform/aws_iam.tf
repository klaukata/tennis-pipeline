# ____________TRUST POLICY____________

# data source for an acces to authorized account id
data "aws_caller_identity" "current" {}

# trust policy - data source that specifies who can assume the 'snowflake_uploader' role
data "aws_iam_policy_document" "iam_trust_policy" {
    statement {
      actions = [ "sts:AssumeRole" ]
      principals {
        type = "AWS"
        identifiers = "arn:aws:iam:${data.aws_caller_identity.current.account_id}:root"
      }
    }
}

# ____________CREATING A ROLE____________
# resource that creates a role
resource "aws_iam_role" "snowflake_uploader" {
    name = "snowflake_uploader"
    description = "Role that will upload the most recent .csv file to Snowflake"
    assume_role_policy = data.aws_iam_policy_document.iam_trust_policy
}

# ____________PERMISSIONS POLICY____________