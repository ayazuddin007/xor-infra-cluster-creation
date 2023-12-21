variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

data "aws_subnets" "allsubnetIds" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

variable "vpc_cidr" {
  type = string
}

variable "client_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region_name" {
  type = string
}

variable "cluster_subnets" {
  type = list(any)
}


variable "Node_group_subnets" {
  type = list(any)
}

variable "Cluster_version" {
  type =  string
}

variable "Node_group_scaling_config_desired_size" {
  type = number
}

variable "Node_group_scaling_config_max_size" {
  type = number
}

variable "Node_group_scaling_config_min_size" {
  type = number
}

variable "Node_group_instance_type" {
  type = string
}

variable "Nodegroup_ebs_volume" {
  type = number
}

variable "Node_group_ami_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "line_of_bussiness" {
  type = string
}

variable "BillingId" {
  type = string
}

variable "Owner" {
  type = string
}

variable "Application" {
  type = string
}

locals {
  cluster-name                = "${var.client_name}-${var.environment}-${var.region_name}-eks-cluster"
  nodeGroupName               = "${var.client_name}-${var.environment}-${var.region_name}-ng"
  cluster_security_group_cidr = "${data.external.ipPrivate.result.ip}/32"
}

