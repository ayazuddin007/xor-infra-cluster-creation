#GETTING THE SERVICE NAME OF NGINX-CONTROLLER AND SAVING IT IN A LOCAL FILE
resource "null_resource" "getSvcName" {
  provisioner "local-exec" {
    command = "kubectl get svc -n kube-system | grep \"nginx-controller\" | grep \"NodePort\" | awk '{print $1}' > ../modules/alb_ingress/ingressSvcName.txt"
  }

}

#EXTRACTING THE VALUE SAVED IN FILE BY ABOVE COMMAND
data "local_file" "ingress-svc-name" {
  filename = "../modules/alb_ingress/ingressSvcName.txt"
  depends_on = [null_resource.getSvcName]
}
