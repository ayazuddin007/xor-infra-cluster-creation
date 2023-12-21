#INSTALL CSI DRIVER IN CLUSTER
resource "null_resource" "csi_driver" {
  provisioner "local-exec" {
    command = "kubectl apply -k 'github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.3'"
  }
  depends_on =[
    aws_eks_cluster.demo,
    aws_eks_node_group.demo
  ]
}