#CREATING PV
# resource "kubernetes_persistent_volume" "consul_pv_0" {
#   count = var.consulReplica
#   metadata {
#     name = "efs-consul-pv-${count.index}"
#   }
#   spec {
#     capacity = {
#       storage = "10Gi"
#     }
#     volume_mode                      = "Filesystem"
#     access_modes                     = ["ReadWriteOnce"]
#     persistent_volume_reclaim_policy = "Delete"
#     storage_class_name               = kubernetes_storage_class.consul_sc.metadata.0.name

#     persistent_volume_source {
#       csi {
#         driver        = "efs.csi.aws.com"
#         volume_handle = "${var.fileSystemID}::${var.accessPointId}"
#       }
#     }
#   }

#   depends_on = [
#     kubernetes_storage_class.consul_sc
#   ]
# }
