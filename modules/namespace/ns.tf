#CREATE TARGET NAMESPACE
resource "kubernetes_namespace" "ns" {
  metadata {
    annotations = {
      name = "${var.env_ns}"
    }

    name = var.env_ns
  }
}

resource "null_resource" "add_custom_tags_to_asg" {
  depends_on = [
    kubernetes_namespace.ns
  ]

  provisioner "local-exec" {      
    command = "sh ../modules/namespace/kubernetes-secrets.sh"  
  }
  
}
