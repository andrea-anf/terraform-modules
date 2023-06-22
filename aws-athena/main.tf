data "aws_subnet" "selected" {
  id = var.subnet_id
}

resource "aws_glue_connection" "athena_aurora_connection" {
  name            = var.connection_name
  connection_type = var.connection_type

  physical_connection_requirements {
    availability_zone      = data.aws_subnet.selected.availability_zone
    subnet_id              = var.subnet_id
    security_group_id_list = [var.security_group_id]
  }

  connection_properties = {
    "JDBC_CONNECTION_URL" = var.jdbc_connection_url
    "USERNAME"            = var.rds_master_username
    "PASSWORD"            = var.rds_master_password
    "JDBC_ENFORCE_SSL"    = var.jdbc_enforce_ssl
  }
}

