resource "kubernetes_ingress" "grafana" {
  metadata {
    name = "ingress-service-grafana"
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
            service_name = "prometheus-grafana"
            service_port = 80
          }
        }
      }
    }
  }
}

