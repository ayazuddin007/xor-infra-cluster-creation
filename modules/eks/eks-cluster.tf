#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "demo-cluster" {
  name = "${var.client_name}-${var.environment}-${var.region_name}-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo-cluster.name
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.demo-cluster.name
}


resource "aws_security_group" "demo-cluster" {
  name        = "${var.client_name}-${var.environment}-${var.region_name}-cluster-security-group"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [local.cluster_security_group_cidr]
  }

  ingress {
    from_port   = 8000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${var.client_name}-${var.environment}-${var.region_name}-cluster-security-group"
  }
}

#CREATING EKS CLUSTER
resource "aws_eks_cluster" "demo" {
  version = var.Cluster_version
  name     = local.cluster-name
  role_arn = aws_iam_role.demo-cluster.arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
    security_group_ids      = [aws_security_group.demo-cluster.id]
    subnet_ids              = var.cluster_subnets
  }
  
  tags = {
    "NOSCHEDULE" = "EKS"
  }

  depends_on = [
    aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.demo-cluster-AmazonEKSVPCResourceController,
  ]

  provisioner "local-exec" {    
    when    = destroy    
    command = "sh ../modules/eks/oidc_cleanup.sh ${self.id}"  
  }
}

#RULE FOR ALLOWING RUNNING GIT-TO-CONSUL FUNCTIONALITY
resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_eks_cluster.demo.vpc_config.0.cluster_security_group_id
}