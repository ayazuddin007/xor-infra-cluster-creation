#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "demo-node" {
  name_prefix = "${var.client_name}-${var.environment}-${var.region_name}-nodeGroup-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEC2FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.demo-node.name
}


resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonElasticFileSystemFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
  role       = aws_iam_role.demo-node.name
}

resource "aws_security_group" "remote_access" {
  name        = "${var.client_name}-${var.environment}-${var.region_name}-cluster-security-group-remote-access"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "eks:nodegroup-name" = "${local.cluster-name}"
    "eks" = "${local.cluster-name}"

  }
}

#LAUNCH TEMPLATE FOR NODES OF NODE GROUP 
resource "aws_launch_template" "Node_Template" {
  name = "${var.client_name}-${var.environment}-${var.region_name}-nodegroup-template"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.Nodegroup_ebs_volume
      volume_type           = "gp2"
      encrypted             = true
      delete_on_termination = true
    }
  }

  image_id = var.Node_group_ami_id
  instance_type = var.Node_group_instance_type
  key_name = "deployer-key"

  vpc_security_group_ids = [aws_eks_cluster.demo.vpc_config.0.cluster_security_group_id,  aws_security_group.remote_access.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
        LOB = "${var.line_of_bussiness}"
        BillingId = "${var.BillingId}"
        Environment = "${var.environment}"
        Lifespan = "+90 days"
        Owner = "${var.Owner}"
        Client = "${var.client_id}"
        PatchGroup = "appliance"
        "cpm backup" = "no-backup"
        Name = "${var.client_name}-${var.environment}-${var.region_name}-nodegroup-node"
        "k8s.io/cluster-autoscaler/${local.cluster-name}" = "owned"
        "k8s.io/cluster-autoscaler/enabled" = "TRUE"
        "kubernetes.io/cluster/${local.cluster-name}" = "owned"

    }
  }

  user_data = base64encode(templatefile("../modules/eks/userdata.tpl", { CLUSTER_NAME = aws_eks_cluster.demo.name, B64_CLUSTER_CA = aws_eks_cluster.demo.certificate_authority[0].data, API_SERVER_URL = aws_eks_cluster.demo.endpoint }))

  depends_on = [
aws_security_group.remote_access
  ]

}

#CREATING NODE GROUP USING LAUNCH TEMPLATE
resource "aws_eks_node_group" "demo" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name_prefix = local.nodeGroupName
  node_role_arn   = aws_iam_role.demo-node.arn
  subnet_ids      = var.Node_group_subnets
  launch_template {
    id = aws_launch_template.Node_Template.id
    version = aws_launch_template.Node_Template.latest_version
  } 
  
  scaling_config {
    desired_size = var.Node_group_scaling_config_desired_size
    max_size     = var.Node_group_scaling_config_max_size
    min_size     = var.Node_group_scaling_config_min_size
  }

  tags = {
     "k8s.io/cluster-autoscaler/${local.cluster-name}" = "owned"
     "k8s.io/cluster-autoscaler/enabled" = "TRUE"
     "kubernetes.io/cluster/eks" = "owned"
  }

  depends_on = [
    aws_iam_role_policy_attachment.demo-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.demo-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.demo-node-AmazonEC2ContainerRegistryReadOnly,

  ]

  lifecycle {    create_before_destroy = true  }
  
}
locals {
  asg_name = aws_eks_node_group.demo.resources.0.autoscaling_groups.0.name
}

resource "null_resource" "add_custom_tags_to_asg" {
  triggers = {
    node_group = local.asg_name
  }
  provisioner "local-exec" {
    command = "aws autoscaling create-or-update-tags --tags ResourceId=${local.asg_name},ResourceType=auto-scaling-group,'Key=ASGON,Value=\"on=(M-U,0);tz=est\"',PropagateAtLaunch=true && aws autoscaling start-instance-refresh --auto-scaling-group-name ${local.asg_name} --region ${var.aws_region}"

  }
  
}
