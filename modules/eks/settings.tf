#setting local context

resource "null_resource" "set_local_context" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${local.cluster-name}"
  }

  depends_on = [
    aws_eks_cluster.demo
  ]
}

resource "null_resource" "change_kubectx_context" {
  provisioner "local-exec" {
    command = "sudo chmod 740 ../modules/eks/contextSet.sh && sh ../modules/eks/contextSet.sh ${local.cluster-name}"
  }

  depends_on = [
    null_resource.set_local_context,
    aws_eks_cluster.demo
  ]
}
