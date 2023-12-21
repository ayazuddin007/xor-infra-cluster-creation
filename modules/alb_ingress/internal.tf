#CREATING INTERNAL LOADBALANCER
resource "kubernetes_ingress" "internal_ingress" {
  metadata {
    name = "${var.env_ns}-alb-nginx-private"
    namespace = "kube-system"
    annotations = {
        "alb.ingress.kubernetes.io/certificate-arn" : "${var.acm_arn}"
        "alb.ingress.kubernetes.io/listen-ports" : "[{\"HTTP\": 80}, {\"HTTP\": 9195}, {\"HTTP\": 8080}, {\"HTTPS\": 443}]"
        "alb.ingress.kubernetes.io/healthcheck-path" : "/healthz"
        "alb.ingress.kubernetes.io/scheme": "internal"
        "alb.ingress.kubernetes.io/target-type": "ip"
        "alb.ingress.kubernetes.io/load-balancer-attributes": "idle_timeout.timeout_seconds=4000"
        "kubernetes.io/ingress.class": "alb"
    }
  }

  spec {
   
    rule {
      http {
        path {
          backend {
            service_name = trim(data.local_file.ingress-svc-name.content,"\n")
            service_port = 80
          }

          path = "/*"
        }

      }
    }

  }
}
