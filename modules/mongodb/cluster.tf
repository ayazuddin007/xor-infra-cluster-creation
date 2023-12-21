#CREATING DOCUMENTDB CLUSTER AND INSTANCE
resource "aws_docdb_cluster" "mongodb_cluster" {
  count = var.mongoFlag
  cluster_identifier = "${var.mongodbclusterName}"
  master_username    = "${var.mongodbusername}"
  master_password    = "${var.mongodbpassword}"
  db_subnet_group_name = aws_docdb_subnet_group.default.0.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.parameter_group.0.name
  port = "${var.clusterPort}"
  vpc_security_group_ids = [aws_security_group.mongo_sg.0.id]
  
 
  tags = {
    "BillingId" = "${var.BillingId}"
    "AppRole" = "mongodb"
    "Client" = "${var.client_name}"
    "Environment" = "${var.environment}"
    "Application" =	"${var.Application}"
    "LOB" =	"${var.line_of_bussiness}"
    "Name"=	"${var.mongodbclusterName}"
  }

 
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count = var.mongoFlag
  identifier         = "${var.mongodbclusterName}"
  cluster_identifier = aws_docdb_cluster.mongodb_cluster.0.id
  instance_class     = "${var.mongodbInstanceClass}"
  promotion_tier = 1

  tags = {
    "BillingId" = "${var.BillingId}"
    "AppRole" = "mongodb"
    "Client" = "${var.client_name}"
    "Environment" = "${var.environment}"
    "Application" =	"${var.Application}"
    "LOB" =	"${var.line_of_bussiness}"
    "Name"=	"${var.mongodbclusterName}"
  }

   lifecycle {
    ignore_changes = [
      tags,
      tags_all

    ]
  }
}
