#CREATING SERVICE ACCOUNT
resource "kubernetes_service_account" "autoscaler_service_account" {
  metadata {
    name = "cluster-autoscaler"
    namespace =  "kube-system"
    annotations = {
        "eks.amazonaws.com/role-arn" : aws_iam_role.kubernetes_cluster_autoscaler.arn
        "app.kubernetes.io/name" : "cluster-autoscaler"
    }
  }
  
  depends_on = [
      aws_iam_role.kubernetes_cluster_autoscaler,
  ]
}