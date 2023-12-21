locals {
  cluster-name  = "${var.client_name}-${var.environment}-${var.region_name}-eks-cluster"
  nodeGroupName = "${var.client_name}-${var.environment}-${var.region_name}-node-group"

  #constructing flags 
  sqsFlag = [for i in var.createSQSqueue : "${i ? 1:0}"]
  mongoFlag = [for i in var.createMongodb : "${i ? 1:0}"]
  postgresFlag = [for i in var.createPostgres : "${i ? 1:0}"]

  github_password = jsondecode(data.aws_secretsmanager_secret_version.getSecret.secret_string)["github_password"]

}

data "aws_secretsmanager_secret_version" "getSecret" {
  secret_id = "git_jfrog_credentials"
}
