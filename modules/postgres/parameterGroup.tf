#aws_db_parameter_group
resource "aws_rds_cluster_parameter_group" "postgres_param" {
  count = var.postgresFlag
  name   = "${var.client_name}-${var.env_ns}-postgres-parametergroup"
  family = "aurora-postgresql13"
  description = "Parameter group for rds-pg cluster"

  parameter {
    name  = "timezone"
    value = "UTC"
  }

  parameter {
    name  = "rds.enable_plan_management"
    value = "1"
    apply_method = "pending-reboot"
  }

  tags = {
      LOB = "${var.line_of_bussiness}"
      Environment = "${var.environment}"
      Name = "${var.client_name}-${var.env_ns}-postgres-parametergroup"

  }
}

resource "aws_db_parameter_group" "postgres_param_instance" {
  count = var.postgresFlag
  name   = "${var.client_name}-${var.env_ns}-postgres-instance-parametergroup"
  family = "aurora-postgresql13"
  description = "Parameter group for rds-pg instance"

  parameter {
    name  = "apg_plan_mgmt.capture_plan_baselines"
    value = "automatic"
  }

  parameter {
    name  = "apg_plan_mgmt.use_plan_baselines"
    value = "True"
  }

  tags = {
      LOB = "${var.line_of_bussiness}"
      Environment = "${var.environment}"
      Name = "${var.client_name}-${var.env_ns}-postgres-instance-parametergroup"

  }
}
