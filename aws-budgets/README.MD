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
| [aws_budgets_budget.terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_type"></a> [budget\_type](#input\_budget\_type) | Whether this budget tracks monetary cost or usage | `string` | `"COST"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Map with default tags | `map(string)` | n/a | yes |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | The amount of cost or usage being measured for a budget | `string` | `"100"` | no |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB | `string` | `"USD"` | no |
| <a name="input_notification_comparison_operator"></a> [notification\_comparison\_operator](#input\_notification\_comparison\_operator) | Comparison operator to use to evaluate the condition. Can be LESS\_THAN, EQUAL\_TO or GREATER\_THAN | `string` | `"GREATER_THAN"` | no |
| <a name="input_notification_notification_type"></a> [notification\_notification\_type](#input\_notification\_notification\_type) | What kind of budget value to notify on. Can be ACTUAL or FORECASTED | `string` | `"FORECASTED"` | no |
| <a name="input_notification_subscriber_email_addresses"></a> [notification\_subscriber\_email\_addresses](#input\_notification\_subscriber\_email\_addresses) | E-Mail addresses to notify. | `list(string)` | n/a | yes |
| <a name="input_notification_threshold"></a> [notification\_threshold](#input\_notification\_threshold) | Threshold when the notification should be sent | `number` | `1` | no |
| <a name="input_notification_threshold_type"></a> [notification\_threshold\_type](#input\_notification\_threshold\_type) | What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE\_VALUE | `string` | `"PERCENTAGE"` | no |
| <a name="input_time_period_end"></a> [time\_period\_end](#input\_time\_period\_end) | The end of the time period covered by the budget. Format: 2017-01-01\_12:00 | `string` | `"2087-06-15_00:00"` | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | The start of the time period covered by the budget. Format: 2017-01-01\_12:00 | `string` | `"2017-07-01_00:00"` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY | `string` | `"MONTHLY"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_budget_arn"></a> [aws\_budget\_arn](#output\_aws\_budget\_arn) | aws budget ARN |
| <a name="output_aws_budget_id"></a> [aws\_budget\_id](#output\_aws\_budget\_id) | aws budget ID |
<!-- END_TF_DOCS -->