#DOWNLOADING PRE-REQUISUT FOR HORIZONTAL POD AUTOSCALER
resource "null_resource" "hpa" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
  }

  depends_on=[
     helm_release.cluster_autoscaler 
  ]
}