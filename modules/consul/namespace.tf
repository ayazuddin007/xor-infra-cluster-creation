#CREATING NAMESPACE
resource "kubernetes_namespace" "ns" {
  metadata {
    annotations = {
      name = "consul"
    }

    name = "consul"
  }
}