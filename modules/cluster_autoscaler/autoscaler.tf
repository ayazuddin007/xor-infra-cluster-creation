#CREATE AUTOSCALAR USING HELM
resource "helm_release" "cluster_autoscaler" {
  name       = var.helm_chart_name
  chart      = var.helm_chart_release_name
  repository = var.helm_chart_repo
  version    = var.helm_chart_version
  namespace  = var.namespace

  
  set {
    name  = "fullnameOverride"
    value = var.fullname_override
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.ClusterName
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

   depends_on = [
    kubernetes_service_account.autoscaler_service_account,
      ]

}
