# #INSTALLING PROMETHEUS AND GRAFANA USING HELM CHART
# data "aws_secretsmanager_secret_version" "getSecret" {
#   secret_id = "git_jfrog_credentials"
# }

# locals {
#   grafana_password = jsondecode(data.aws_secretsmanager_secret_version.getSecret.secret_string)["grafana_password"]
# }

resource "helm_release" "prometheus" {
  name             = var.helm_chart_prometheus_release_name
  chart            = var.helm_chart_prometheus_name
  repository       = var.helm_chart_prometheus_repo
  namespace        = var.namespace
  create_namespace = true


  values = [
    file("../modules/prometheus_and_grafana/prometheus.yaml")

  ]

  # set {
  #   name  = "grafana.adminPassword"
  #   value = local.grafana_password
  # }

  depends_on = [
    kubernetes_namespace.ns_prom,
    # kubernetes_config_map.configmap1,
    # kubernetes_config_map.configmap2,
    # kubernetes_config_map.configmap3

  ]

}
