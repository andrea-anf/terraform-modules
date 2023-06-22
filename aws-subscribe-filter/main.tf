data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  name            = var.name
  role_arn        = var.role_arn
  log_group_name  = var.log_group_name
  filter_pattern  = var.filter_pattern
  destination_arn = var.destination_arn
}

resource "aws_iam_role" "this" {
  name = "log-subscription-filter"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "eshttppost" {
  name = "test_policy"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "es:ESHttpPost"
        ],
        "Resource": "${var.destination_arn}/*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "escognitoaccess" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonESCognitoAccess"
  role       = aws_iam_role.this.name
}