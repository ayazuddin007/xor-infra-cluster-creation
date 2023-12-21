#CREATE SUBNET GROUP
resource "aws_docdb_subnet_group" "default" {
  count = var.mongoFlag
  name       = "${var.environment}-${var.mongodbclusterName}-subg-docdb"
  subnet_ids = var.cluster_subnets
  tags = {
    Name = "${var.environment}-${var.mongodbclusterName}-subg-docdb"
    Client = "${var.client_name}"
    Environment = "${var.environment}"
    "BillingId" = "${var.BillingId}"
    "AppRole" = "mongodb"
    "Application" =	"${var.Application}"
    "LOB" =	"${var.line_of_bussiness}"
  }
}