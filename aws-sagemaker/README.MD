<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_sagemaker_domain.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_domain) | resource |
| [aws_sagemaker_space.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_space) | resource |
| [aws_sagemaker_studio_lifecycle_config.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_studio_lifecycle_config) | resource |
| [aws_sagemaker_user_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_user_profile) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Map with default tags | `map(string)` | n/a | yes |
| <a name="input_retention_policy_home_efs"></a> [retention\_policy\_home\_efs](#input\_retention\_policy\_home\_efs) | The retention policy for data stored on an EFS volume. Valid values are Retain or Delete. Default value is Retain. | `string` | `"Delete"` | no |
| <a name="input_sagemaker_domain_auth_mode"></a> [sagemaker\_domain\_auth\_mode](#input\_sagemaker\_domain\_auth\_mode) | The mode of authentication that members use to access the domain. Valid values are IAM and SSO. | `string` | `"IAM"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The list of subnet ids to provide to SageMaker | `list(string)` | n/a | yes |
| <a name="input_user_profile_name_list"></a> [user\_profile\_name\_list](#input\_user\_profile\_name\_list) | The list of user profiles to create | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where to deploy SageMaker | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sagemaker_domain_arn"></a> [sagemaker\_domain\_arn](#output\_sagemaker\_domain\_arn) | SageMaker domain ARN |
| <a name="output_sagemaker_domain_id"></a> [sagemaker\_domain\_id](#output\_sagemaker\_domain\_id) | SageMaker domain ID |
| <a name="output_sagemaker_domain_url"></a> [sagemaker\_domain\_url](#output\_sagemaker\_domain\_url) | SageMaker domain URL |
| <a name="output_sagemaker_lifecycle_config_arn"></a> [sagemaker\_lifecycle\_config\_arn](#output\_sagemaker\_lifecycle\_config\_arn) | SageMaker domain URL |
<!-- END_TF_DOCS -->