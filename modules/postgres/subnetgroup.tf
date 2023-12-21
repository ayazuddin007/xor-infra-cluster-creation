#aws_db_subnet_group
resource "aws_db_subnet_group" "db-sng" {
  count = var.postgresFlag
  subnet_ids = var.subnet_ids
  name = "${var.client_name}-${var.env_ns}-postgres-sng"

    tags = {
      LOB = "${var.line_of_bussiness}"
      Environment = "${var.environment}"
      Name = "${var.client_name}-${var.env_ns}-postgres-sng"

  }
}
