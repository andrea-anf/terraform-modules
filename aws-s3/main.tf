resource "aws_s3_bucket" "this" {
  bucket = var.name
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enable_lifecycle == true ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id = "deleteAfter${var.bucket_expiration_days}Day(s)"

    expiration {
      days = var.bucket_expiration_days
    }

    status = var.bucket_lifecycle_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.enable_server_side_encryption == true ? 1 : 0
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "this" {
  count  = var.enable_access_log == true ? 1 : 0
  bucket = var.log_bucket_id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_access_log == true ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = var.log_bucket_id
  target_prefix = "access_log/"
}