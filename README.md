<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_assumable_role"></a> [iam\_assumable\_role](#module\_iam\_assumable\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 4.11.0 |
| <a name="module_iam_group_with_assumable_roles_policy"></a> [iam\_group\_with\_assumable\_roles\_policy](#module\_iam\_group\_with\_assumable\_roles\_policy) | terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy | ~> 4.11.0 |
| <a name="module_iam_user"></a> [iam\_user](#module\_iam\_user) | terraform-aws-modules/iam/aws//modules/iam-user | ~> 4.11.0 |

## Resources

| Name | Type |
|------|------|
| [aws_connect_contact_flow.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/connect_contact_flow) | resource |
| [aws_connect_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/connect_instance) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.lambda_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [archive_file.lambda_function](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.push_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connect_source_phone_number"></a> [connect\_source\_phone\_number](#input\_connect\_source\_phone\_number) | Caller phone number in E.164 format. | `string` | `"+810000000000"` | no |
| <a name="input_system_name"></a> [system\_name](#input\_system\_name) | Your system name | `string` | `"mysystem"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connect_contact_flow_id"></a> [connect\_contact\_flow\_id](#output\_connect\_contact\_flow\_id) | The identifier of the Contact Flow. |
| <a name="output_connect_instance_id"></a> [connect\_instance\_id](#output\_connect\_instance\_id) | The identifier of the Amazon Connect Instance. |
| <a name="output_iam_assumable_role_arn"></a> [iam\_assumable\_role\_arn](#output\_iam\_assumable\_role\_arn) | The ARN of IAM role attached policy publish to the sns topic. |
| <a name="output_iam_user"></a> [iam\_user](#output\_iam\_user) | IAM user who can assume IAM role. |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of Lambda function. |
| <a name="output_lambda_iam_role_arn"></a> [lambda\_iam\_role\_arn](#output\_lambda\_iam\_role\_arn) | The ARN of IAM role associated with Lambda function. |
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The ARN of SNS topic for invoking lambda function. |
<!-- END_TF_DOCS -->