#CREATING PVC
# resource "kubernetes_persistent_volume_claim" "consul_pvc_0" {
#   count = var.consulReplica
#   metadata {
#     name      = "data-consul-consul-server-${count.index}"
#     namespace = "consul"
#   }
#   spec {
#     access_modes = ["ReadWriteOnce"]
#     resources {
#       requests = {
#         storage = "10Gi"
#       }
#     }
#     storage_class_name = kubernetes_storage_class.consul_sc.metadata.0.name
#   }

#   depends_on = [
#     kubernetes_persistent_volume.consul_pv_0,
#     kubernetes_storage_class.consul_sc,
#     kubernetes_namespace.ns

#   ]
# }