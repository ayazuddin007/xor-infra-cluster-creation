#ENABLE OICD PROVIDER FOR CLUSTER
resource "null_resource" "set_OIDC_provider" {
  provisioner "local-exec" {
    command = "eksctl utils associate-iam-oidc-provider --cluster ${local.cluster-name} --approve --region ${var.aws_region}"
  }

  depends_on = [
    aws_eks_cluster.demo,
    aws_eks_node_group.demo
  ]
}
