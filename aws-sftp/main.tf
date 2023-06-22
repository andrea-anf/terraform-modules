
resource "aws_s3_bucket" "this" {
  bucket = "${var.default_tags["Project_prefix"]}-sftp-${var.default_tags["CostCenter"]}-${var.default_tags["Environment"]}"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/* resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id = "deleteAfter${var.bucket_data_expiration_days}Day(s)"

    expiration {
      days = var.bucket_data_expiration_days
    }

    status = var.bucket_data_lifecycle_status
  }
} */

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_object" "input_folder" {
  bucket = aws_s3_bucket.this.id
  key    = "in/"
}

resource "aws_s3_bucket_object" "output_folder" {
  bucket = aws_s3_bucket.this.id
  key    = "out/"
}


resource "aws_transfer_server" "sftp" {
  endpoint_type = "VPC"
  domain        = "S3"
  endpoint_details {
    subnet_ids         = var.subnet_ids
    vpc_id             = var.vpc_id
    security_group_ids = var.network_security_group_ids
  }
  protocols              = ["SFTP"]
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = var.role_arn
  tags = {
    Name = "${var.default_tags["Project_prefix"]}-sftp-server"
  }
}

resource "aws_transfer_user" "muvi_user" {
  role      = var.access_role_arn
  server_id = aws_transfer_server.sftp.id
  user_name = var.transfer_user_name
  tags = {
    Name = "${var.default_tags["Project_prefix"]}-sftp-muvi"
  }
}

resource "aws_transfer_ssh_key" "muvi_user_ssh" {
  body      = file("./modules/sftp/keys/muvi/martech_lab_nexi_CS_stg.key")
  server_id = aws_transfer_server.sftp.id
  user_name = aws_transfer_user.muvi_user.user_name
}
