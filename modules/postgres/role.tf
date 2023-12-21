#Enhanced monitoring ROLE
resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = var.postgresFlag
  name_prefix        = "rds-enhanced-monitoring-"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.rds_enhanced_monitoring.json

  tags = {
      LOB = "${var.line_of_bussiness}"
      Environment = "${var.environment}"
      Name = "${var.client_name}-${var.env_ns}-postgres-db-role"

  }
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  count = var.postgresFlag
  role       = aws_iam_role.rds_enhanced_monitoring.0.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}


