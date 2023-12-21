#Calling modules to spin up resources in cluster
module "cluster_autoscaler" {
  source          = "../modules/cluster_autoscaler"
  aws_region      = var.aws_region
  OIDC_PROVIDER   = trim(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://")
  ClusterName     = local.cluster-name

}

module "nginx_ingress_controller" {
  source          = "../modules/nginx_ingress_controller"
  aws_region      = var.aws_region
  ClusterName     = local.cluster-name


}


module "alb" {
  source          = "../modules/alb"
  aws_region      = var.aws_region
  OIDC_PROVIDER   = trim(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://")
  ClusterName     = local.cluster-name
  cluster_subnets = var.cluster_subnets

}

module "datadog" {
source                         = "../modules/datadog"
  count = var.installDataDog ? 1 : 0
  helm_chart_datadog_version    = var.helm_chart_datadog_version
  namespace                     = var.datadog_namespace

}





