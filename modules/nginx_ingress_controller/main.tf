#CRETING NGINX-CONTROLLER USING HELM
resource "helm_release" "nginx_ingress_controller" {
  name       = var.helm_chart_name
  chart      = var.helm_chart_release_name
  repository = var.helm_chart_repo
  version    = var.helm_chart_version
  namespace  = var.namespace
  

  set {
    name  = "autoDiscovery.clusterName"
    value = var.ClusterName
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = var.controller_service_externalTrafficPolicy
  }

  set {
    name  = "controller.config.server-tokens"
    value = var.controller_config_server_tokens
  }

  set {
    name  = "controller.config.use-proxy-protocol"
    value = var.controller_config_use_proxy_protocol
  }

   set {
    name  = "controller.config.compute-full-forwarded-for"
    value = var.controller_config_compute_full_forwarded_for
  }

 set {
    name  = "controller.config.use-forwarded-headers"
    value = var.controller_config_use_forwarded_headers
  }

set {
    name  = "controller.metrics.enabled"
    value = var.metrics_enabled
  }

  set {
    name  = "controller.service.type"
    value = var.controller_service_type
  }

}
  