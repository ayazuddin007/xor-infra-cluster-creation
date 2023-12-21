#CREATING CONSUL USING HELM BY PASSING CONFIG.YAML AS IT'S VALUES FILE
resource "helm_release" "consul" {
  name             = var.helm_chart_consul_release_name
  repository       = var.helm_chart_consul_repo
  chart            = var.helm_chart_name
  create_namespace = true
  namespace        = var.namespace
  version = var.consul_chart_version

  values = [
    file("../modules/consul/config.yaml")
  ]

  set {
    name  = "server.replicas"
    value = var.consulReplica
  }

  # set {
  #   name  = "storageClass"
  #   value = kubernetes_storage_class.consul_sc.metadata.0.name
  # }


  depends_on = [
    kubernetes_namespace.ns
    # kubernetes_storage_class.consul_sc,
    # kubernetes_persistent_volume_claim.consul_pvc_0,
  ]

}
