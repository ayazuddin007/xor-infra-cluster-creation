#CREATING INGRESS FOR CONSUL


resource "kubernetes_ingress" "consul_svc" {
  metadata {
    name = "consul-ui"
    namespace = "${var.namespace}"
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "alb.ingress.kubernetes.io/target-type" = "ip"
      "alb.ingress.kubernetes.io/subnets" = "subnet-081105b8da3523a4f, subnet-02a3a4ed6baf8e61d"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = "consul-ui"
            service_port = 80
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.consul
    # kubernetes_storage_class.consul_sc,
    # kubernetes_persistent_volume_claim.consul_pvc_0,
  ]
}
