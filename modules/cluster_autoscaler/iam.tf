#CREATING ROLE
resource "aws_iam_role" "kubernetes_cluster_autoscaler" {
  name = "${var.ClusterName}-cluster-autoscaler"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${local.ACCOUNT_ID}:oidc-provider/${var.OIDC_PROVIDER}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.OIDC_PROVIDER}:sub" : "system:serviceaccount:${var.namespace}:${var.service_account_name}"
          }
        }
      }
    ]
  })

  tags = {
    Name = "${var.ClusterName}-cluster-autoscaler"
  }

  lifecycle {
    ignore_changes = [
      assume_role_policy
    ]
  }
}

#POLICY
resource "aws_iam_policy" "policy" {
  name   = "AmazonEKSClusterAutoscalerPolicy-${var.ClusterName}"
  policy = file("../modules/cluster_autoscaler/policy.json")
}

#ATTACHING POLICY TO ROLE
resource "aws_iam_role_policy_attachment" "alb_policy" {
  role       = aws_iam_role.kubernetes_cluster_autoscaler.name
  policy_arn = aws_iam_policy.policy.arn

}