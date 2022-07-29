#########################################
# SNS Topic
#########################################
resource "aws_sns_topic" "this" {
  name = "${var.system_name}-topic"
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.this.arn
}

#########################################
# Lambda function
#########################################
resource "aws_lambda_function" "this" {
  function_name = "${var.system_name}-function"
  role          = aws_iam_role.lambda.arn

  handler          = "lambda_function.lambda_handler"
  filename         = data.archive_file.lambda_function.output_path
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_function.output_base64sha256
  environment {
    variables = {
      CONNECT_INSTANCE_ID     = aws_connect_instance.this.id
      CONNECT_CONTACT_FLOW_ID = aws_connect_contact_flow.this.contact_flow_id
      SOURCE_PHONE_NUMBER     = var.connect_source_phone_number
    }
  }
  depends_on = [
    aws_iam_role_policy.lambda_logs,
    aws_connect_contact_flow.this,
  ]

}

#########################################
# Lambda permission
#########################################
resource "aws_lambda_permission" "this" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}

#########################################
# Lambda IAM 
#########################################
resource "aws_iam_role" "lambda" {
  name               = "${var.system_name}-lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_logs" {
  name   = "${var.system_name}-lambda-logging_policy"
  role   = aws_iam_role.lambda.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_connect" {
  name   = "${var.system_name}-lambda-connect-policy"
  role   = aws_iam_role.lambda.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "connect:StartOutboundVoiceContact",
                "connect:StopContact",
                "connect:Get*",
                "lambda:GetFunction"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

#########################################
# IAM
#########################################
resource "aws_iam_policy" "this" {
  name        = "${var.system_name}-policy"
  description = "IAM policy that push notification to sns topic subscribed by lambda function"

  policy = data.aws_iam_policy_document.push_sns.json

  depends_on = [
    aws_sns_topic.this,
  ]
}

module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 4.11.0"

  name = "${var.system_name}-user"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.11.0"

  create_role = true

  role_name = "${var.system_name}-role"

  trusted_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root",
  ]
  role_requires_mfa                 = false
  custom_role_policy_arns           = [aws_iam_policy.this.arn]
  number_of_custom_role_policy_arns = 1
}

module "iam_group_with_assumable_roles_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version = "~> 4.11.0"

  name = "${var.system_name}-group"
  assumable_roles = [
    module.iam_assumable_role.iam_role_arn
  ]
  group_users = [
    module.iam_user.iam_user_name
  ]
}

#########################################
# Connect
#########################################
resource "aws_connect_instance" "this" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = false
  outbound_calls_enabled   = true
  instance_alias           = "${var.system_name}-instance"
}

resource "aws_connect_contact_flow" "this" {
  instance_id  = aws_connect_instance.this.id
  name         = "${var.system_name} outbound flow"
  description  = "Outbound contact flow for ${var.system_name}"
  type         = "CONTACT_FLOW"
  filename     = "src/connect/basic_outbound_flow.json"
  content_hash = filebase64sha256("src/connect/basic_outbound_flow.json")
}

# You will have to add a resouce to claim the phone-number,
# but you will have to claim it manually,
# since the corresponding resource is not available at that time
