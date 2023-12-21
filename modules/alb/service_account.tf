#CREATING SERVICE ACCOUNT
resource "kubernetes_service_account" "alb_service_account" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace =  "kube-system"
    annotations = {
        "eks.amazonaws.com/role-arn" : aws_iam_role.alb_role.arn
        "app.kubernetes.io/component" : "controller"
        "app.kubernetes.io/name" : "aws-load-balancer-controller"
    }
  }
  
  depends_on = [
      aws_iam_role.alb_role,
  ]
}