#Creating cluster
module "eks" {
  source                                 = "../modules/eks"
  Cluster_version                        = var.Cluster_version
  aws_region                             = var.aws_region
  vpc_id                                 = var.vpc_id
  client_name                            = var.client_name
  environment                            = var.environment
  region_name                            = var.region_name
  cluster_subnets                        = var.cluster_subnets
  Node_group_subnets                     = var.Node_group_subnets
  Node_group_scaling_config_desired_size = var.Node_group_scaling_config_desired_size
  Node_group_scaling_config_max_size     = var.Node_group_scaling_config_max_size
  Node_group_scaling_config_min_size     = var.Node_group_scaling_config_min_size
  Node_group_instance_type               = var.Node_group_instance_type
  Node_group_ami_id                      = var.Node_group_ami_id
  Nodegroup_ebs_volume = var.Nodegroup_ebs_volume
  vpc_cidr = var.vpc_cidr
  client_id = var.client_id
  line_of_bussiness= var.line_of_bussiness
  BillingId = var.BillingId
  Owner = var.Owner
  Application = var.Application
}

