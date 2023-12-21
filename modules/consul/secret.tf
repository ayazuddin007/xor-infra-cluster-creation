#ACCESSING THE SECRET MANAGER FOR 'git_jfrog_credentials' SECRET
# data "aws_secretsmanager_secret_version" "getSecret" {
#   secret_id = "git_jfrog_credentials"
# }

# locals {
#   consul_username = jsondecode(data.aws_secretsmanager_secret_version.getSecret.secret_string)["consul_username"]
#   consul_password = jsondecode(data.aws_secretsmanager_secret_version.getSecret.secret_string)["consul_password"]

# }

# #CREATING THE SECRET CRED USING HTPASSWD COMMANDLINE UTILITY
# resource "null_resource" "createSecretCred" {
#   provisioner "local-exec" {
#     command = "htpasswd -c -b auth ${local.consul_username} ${local.consul_password}"
#   }
#   depends_on = [helm_release.consul]
# }


# data "local_file" "readSecret" {
#   filename = "auth"
#   depends_on = [null_resource.createSecretCred]
# }

# #CREATING KUBERNETES SECRET
# resource "kubernetes_secret" "authSecret" {
#   metadata {
#     name = "basic-auth"
#     namespace = var.namespace
#   }

#   data = {
#     auth = trim(data.local_file.readSecret.content,"\n")
#   }

#   type = "Opaque"
# }
