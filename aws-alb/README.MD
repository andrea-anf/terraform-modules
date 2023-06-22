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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.container_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.container_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_acm_certificate.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_account"></a> [alb\_account](#input\_alb\_account) | The account number for the ALB (default is set for eu-central-1). See https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html | `string` | `"054676820928"` | no |
| <a name="input_certificate_domain"></a> [certificate\_domain](#input\_certificate\_domain) | Domain of the certificate to look up. If no certificate is found with this name, an error will be returned | `string` | `""` | no |
| <a name="input_enable_access_logs"></a> [enable\_access\_logs](#input\_enable\_access\_logs) | Define if send access logs to a S3 Bucket | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false | `bool` | `false` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | If true, the LB will be internal | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | The security group IDs to attach to the ALB, if empty the default one will be fetched | `list(string)` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs where to attach the ALB | `list(string)` | n/a | yes |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | The name of the target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | The ARN of the application load balancer |
| <a name="output_alb_container_listener_arn"></a> [alb\_container\_listener\_arn](#output\_alb\_container\_listener\_arn) | The ARN of the HTTP listener (8000) |
| <a name="output_alb_http_listener_arn"></a> [alb\_http\_listener\_arn](#output\_alb\_http\_listener\_arn) | The ARN of the HTTP listener (80) |
<!-- END_TF_DOCS -->