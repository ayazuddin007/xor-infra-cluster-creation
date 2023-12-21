locals {
  cluster-name  = "${var.client_name}-${var.environment}-${var.region_name}-eks-cluster"
  nodeGroupName = "${var.client_name}-${var.environment}-${var.region_name}-node-group"

}
