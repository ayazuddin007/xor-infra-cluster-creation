#GETTING SERVICE NAME FOR NGINX-CONTROLLER AND SAVING IT IN FILE
# resource "null_resource" "getSvcName" {
#   provisioner "local-exec" {
#     command = "kubectl get svc -n kube-system | grep \"nginx-controller\" | grep \"NodePort\" | awk '{print $1}' > ../modules/consul/ingressSvcName.txt"
#   }

# }

# #EXTRACTING THE VALUE FROM FILE STORED BY ABOVE RESOURCE
# data "local_file" "ingress-svc-name" {
#   filename = "../modules/consul/ingressSvcName.txt"
#   depends_on = [null_resource.getSvcName]
# }