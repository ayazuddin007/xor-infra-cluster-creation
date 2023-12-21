variable "aws_region" {
  type = string
}

variable "OIDC_PROVIDER" {
  type = string
}

variable "ClusterName" {
  type = string
}

variable "namespace" {
  default = "kube-system"
}

variable "cluster_subnets" {
  type = list(any)
}

variable "service_account_name" {
  type    = string
  default = "aws-load-balancer-controller"
}
