#INSTALLING DATADOG AGENTS USING HELM_CHART

data "aws_secretsmanager_secret_version" "getSecret" {
  secret_id = "git_jfrog_credentials"
}

locals {
  datadog_api_key = jsondecode(data.aws_secretsmanager_secret_version.getSecret.secret_string)["datadog_api_key"]
}


resource "helm_release" "datadog_agent" {
  name       = var.helm_chart_datadog_release_name
  chart      = var.helm_chart_datadog_name
  repository = var.helm_chart_datadog_repo
  version    = var.helm_chart_datadog_version
  namespace  = var.namespace
  create_namespace = true

  values = [
      file("../modules/datadog/datadog.yaml")

  ]


  set_sensitive {
    name  = "datadog.apiKey"
    value =  local.datadog_api_key
  }

  depends_on = [
      kubernetes_namespace.ns_datadog
  ]
}
