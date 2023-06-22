resource "aws_glue_crawler" "this" {
  name          = var.crawler_name
  database_name = var.database_name
  role          = var.crawler_iam_role
  table_prefix  = var.table_prefix

  dynamic "s3_target" {
    for_each = var.bucket_target_path != "" ? [0] : []
    content {
      path = var.bucket_target_path
    }
  }

  dynamic "jdbc_target" {
    for_each = var.jdbc_target_path != "" ? [0] : []
    content {
      connection_name = var.jdbc_connection_name
      path            = var.jdbc_target_path
    }
  }

}