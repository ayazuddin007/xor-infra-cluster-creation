#CREATING NS FOR PROMETHEUS AND GRAFANA DEPLOYMENT
resource "kubernetes_namespace" "ns_prom" {
  metadata {
    annotations = {
      name = "${var.namespace}"
    }

    name = "${var.namespace}"
  }
}