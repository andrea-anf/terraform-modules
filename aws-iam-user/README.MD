# Introduction
This module define a IAM user who can access the resources defined in the project_list variable.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.61.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix for the IAM user name | `string` | `"iam-user"` | no |
| <a name="input_project_list"></a> [project\_list](#input\_project\_list) | List of objects containing name, bucket arn, list of lambda and step function arns for each project | <pre>list(object({<br>    name = string,<br>    lambda_arns = list(string),<br>    step_function_arns = list(string),<br>    s3_bucket_arn = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->