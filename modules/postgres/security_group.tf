#aws_security_group
resource "aws_security_group" "pg_sg" {
  count = var.postgresFlag
  name = "${var.client_name}-${var.env_ns}-postgres-sg"

  description = "Allow PostgreSQL connection from IP / CIDR.(terraform-managed)"
  vpc_id = var.vpc_id

  # Only postgres in
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      LOB = "${var.line_of_bussiness}"
      Environment = "${var.environment}"
      Name = "${var.client_name}-${var.env_ns}-postgres-sg"

  }
}
