#CREATING SECURITY GROUP
resource "aws_security_group" "mongo_sg" {
  count = var.mongoFlag
  name        = "${var.mongodbclusterName}-sg"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/12"]
  }
  tags = {
    "BillingId" = "${var.BillingId}"
    "AppRole" = "mongodb"
    "Client" = "${var.client_name}"
    "Environment" = "${var.environment}"
    "Application" =	"${var.Application}"
    "LOB" =	"${var.line_of_bussiness}"
    "Name"=	"${var.mongodbclusterName}-sg"

  }
}
