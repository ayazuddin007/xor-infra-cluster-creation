#DOWNLOADING CERTS
resource "null_resource" "certs" {
  provisioner "local-exec" {
    command = "kubectl apply -k 'github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master'"
  }
}

#HELM CHART
resource "helm_release" "alb" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = var.namespace

  set {
    name  = "clusterName"
    value = var.ClusterName
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  depends_on = [
    kubernetes_service_account.alb_service_account,
    null_resource.certs,
  ]

}
