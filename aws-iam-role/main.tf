data "aws_caller_identity" "current" {}

resource "aws_iam_role" "role" {
  name = "GAPSHS-${var.role_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = var.role_services
        }
      }
    ]
  })
  path                 = var.path
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ScopePermissionBoundary"
}

resource "aws_iam_role_policy" "policy" {
  count = length(var.role_policies)
  name  = var.role_policies[count.index].name
  role  = aws_iam_role.role.id

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid      = var.role_policies[count.index].sid
          Effect   = var.role_policies[count.index].effect
          Action   = var.role_policies[count.index].action
          Resource = var.role_policies[count.index].resource
        }
      ]
    }
  )
}