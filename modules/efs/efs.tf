
# Elastic File System

#CREATING SECURITY GROUP
resource "aws_security_group" "demo-efs" {
  name        = "${var.env_ns}-${var.region_name}-efs"
  description = "Communication to efs"
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-efs"
  }
}

#CREATING FILE SYSTEM
resource "aws_efs_file_system" "demo" {
  creation_token = "${var.env_ns}-${var.region_name}-token-efs-eks"
  encrypted      = true
  tags = {
    Name = "${var.env_ns}-${var.region_name}-efs"
  }
}

#CREATING MOUNT TARGET IN EACH SUBNET
resource "aws_efs_mount_target" "demo" {

  count           = length(var.cluster_subnets)
  file_system_id  = aws_efs_file_system.demo.id
  subnet_id       = element(var.cluster_subnets.*, count.index)
  security_groups = ["${aws_security_group.demo-efs.id}"]
}

#CREATING ACCESS POINT
resource "aws_efs_access_point" "demo" {
  file_system_id = aws_efs_file_system.demo.id

  posix_user {
    gid = var.owner_gid
    uid = var.owner_uid
  }

  root_directory {
    path = var.path


    creation_info {
      owner_gid   = var.owner_gid
      owner_uid   = var.owner_uid
      permissions = var.permissions
    }
  }
}
