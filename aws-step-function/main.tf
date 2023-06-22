/* data "template_file" "this" {
  # JSON file with step-function's definition
  template = file(var.states_json_file)
}*/

resource "aws_sfn_state_machine" "this" {
  name     = var.name
  role_arn = var.iam_role_arn
  type     = var.type

  definition = var.state_machine_definition

  logging_configuration {
    log_destination        = "${aws_cloudwatch_log_group.this.arn}:*"
    include_execution_data = var.logging_include_execution_data
    level                  = var.logging_level
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/state_machine/${var.name}"
  retention_in_days = var.logs_retention_in_days
}