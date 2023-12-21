#DOWNLOADING PRE-REQUISITE FOR CERT-MANAGER
resource "null_resource" "cert_manager" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.3/cert-manager.yaml"
  }

  
}

#CREATING ISSUER FOR TARGET NAMESPACE
resource "kubernetes_manifest" "issuer" {

  depends_on = [
      null_resource.cert_manager,
  ]
  manifest = {
  "apiVersion" = "cert-manager.io/v1"
  "kind" = "Issuer"
  "metadata" = {
    "name" = "selfsigned-${var.env_ns}-issuer"
    "namespace" = "${var.env_ns}"
  }
  "spec" = {
    "selfSigned" = {}
  }
}


}
