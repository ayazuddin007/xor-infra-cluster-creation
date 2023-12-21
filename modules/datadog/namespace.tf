#CREATING NS DATADOG AGENT CREATION
resource "kubernetes_namespace" "ns_datadog" {
  metadata {
    annotations = {
      name = "${var.namespace}"
    }

    name = "${var.namespace}"
  }
}