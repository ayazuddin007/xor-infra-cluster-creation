#CREATING THE STORAGE CLASS
# resource "kubernetes_storage_class" "consul_sc" {
#   metadata {
#     name = "consul-sc"
#   }
#   storage_provisioner = "efs.csi.aws.com"
#   reclaim_policy      = "Retain"
#   parameters = {
#     fileSystemId = "${var.fileSystemID}"
#   }


# }
