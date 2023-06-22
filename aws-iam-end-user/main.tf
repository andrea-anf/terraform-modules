data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_user" "this" {
  name = "${var.name_prefix}_${var.user_name}_${terraform.workspace}"
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ScopePermissionBoundary"
}

resource "aws_iam_user_policy" "this" {
  count = length(var.user_policies)
  name  = var.user_policies[count.index].name
  user = aws_iam_user.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
          Sid      = var.user_policies[count.index].sid
          Effect   = var.user_policies[count.index].effect
          Action   = var.user_policies[count.index].action
          Resource = var.user_policies[count.index].resource
        }
      ]
  })
}