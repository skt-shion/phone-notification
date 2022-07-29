# Data source settings
#########################################
# Identity
#########################################
data "aws_caller_identity" "this" {}

#########################################
# Archive
#########################################
data "archive_file" "lambda_function" {
  type        = "zip"
  source_dir  = "src/lambda_function"
  output_path = "archives/lambda_function.zip"
}

#########################################
# IAM
#########################################
data "aws_iam_policy_document" "push_sns" {
  statement {
    sid = "sns"

    effect = "Allow"

    actions = [
      "sns:Publish",
      "sns:GetTopicAttributes"
    ]

    resources = [
      aws_sns_topic.this.arn
    ]
  }
}

