data "aws_iam_policy_document" "policy_document" {
  dynamic "statement" {
    for_each = {
      for index, elem in var.policy_statements :
      index => elem
    }
    content {
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${var.policy_name}-policy"
  policy = data.aws_iam_policy_document.policy_document.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  for_each   = toset(var.roles_name)
  role       = each.value
  policy_arn = aws_iam_policy.policy.arn
}