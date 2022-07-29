output "sns_topic_arn" {
  value       = aws_sns_topic.this.arn
  description = "The ARN of SNS topic for invoking lambda function."
}

output "lambda_function_arn" {
  value       = aws_lambda_function.this.arn
  description = "The ARN of Lambda function."
}

output "lambda_iam_role_arn" {
  value       = aws_iam_role.lambda.arn
  description = "The ARN of IAM role associated with Lambda function."
}

output "iam_assumable_role_arn" {
  value       = module.iam_assumable_role.iam_role_arn
  description = "The ARN of IAM role attached policy publish to the sns topic."
}

output "iam_user" {
  value       = module.iam_user.iam_user_name
  description = "IAM user who can assume IAM role."
}

output "connect_instance_id" {
  value       = aws_connect_instance.this.id
  description = "The identifier of the Amazon Connect Instance."
}

output "connect_contact_flow_id" {
  value       = aws_connect_contact_flow.this.contact_flow_id
  description = "The identifier of the Contact Flow."
}
