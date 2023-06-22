/* data "aws_caller_identity" "current" {}

resource "aws_iam_user" "this" {
  name = var.name #"${var.name_prefix}_${var.project_name}_${terraform.workspace}"
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ScopePermissionBoundary"
}

resource "aws_iam_user_policy" "this" {
  name = var.name #"${var.name_prefix}_${var.project_name}_policy_${terraform.workspace}"
  user = aws_iam_user.this.id

  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = toset(var.statements)

    content {
      actions   = statement.value.actions
      effect    = statement.value.effect
      resources = statement.value.resources
    }
  }
} */

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_user" "this" {
  count = length(var.project_list)
  name = "${var.name_prefix}_${var.project_list[count.index].name}_${terraform.workspace}"
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/ScopePermissionBoundary"
}

resource "aws_iam_user_policy" "this" {
  count = length(var.project_list)
  name = "${var.name_prefix}_${var.project_list[count.index].name}_policy_${terraform.workspace}"
  user = aws_iam_user.this[count.index].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Action = [
          "states:StartSyncExecution",
          "states:StartExecution"
        ]
        Effect   = "Allow"
        Resource = formatlist("arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:%s-%s", var.project_list[count.index].step_function_names, terraform.workspace)
      },
      {
        Action = [
          "lambda:InvokeFunction",
        ]
        Effect   = "Allow"
        Resource = formatlist("arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:%s-%s", var.project_list[count.index].lambda_names, terraform.workspace)
      },
      {
        Action = [
          "execute-api:Invoke",
        ]
        Effect   = "Allow"
        Resource = formatlist("arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:%s/%s/POST/%s", "*", terraform.workspace, var.project_list[count.index].api_names)
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "${var.s3_arn}/*",
          "${var.s3_arn}"
        ]
      },
      {
        Action = [
          "s3:*Object"
        ]
        Effect   = "Allow"
        Resource = "${var.s3_arn}/${var.project_list[count.index].name}/*"
      },
      {
        Action = [
          "textract:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Effect   = "Allow"
        Resource = var.kms_arn #"arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
      },
      {
        Action = [
          "dynamodb:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["sagemaker:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}