import {
    to = aws_iam_role.snowflake
    id = data.terraform_remote_state.base.outputs.iam_role_name_id
}

data "aws_iam_policy_document" "iam_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [snowflake_storage_integration.integ.storage_aws_iam_user_arn]
    }
    condition {
      test = "StringEquals"
      variable = "sts:ExternalId"
      values = [snowflake_storage_integration.integ.storage_aws_external_id]
    }
  }
}