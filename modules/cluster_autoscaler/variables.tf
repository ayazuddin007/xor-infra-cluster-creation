variable "aws_region" {
  type = string
}

variable "OIDC_PROVIDER" {
  type = string
}

variable "ClusterName" {
  type = string
}

variable "service_account_name" {
  type        = string
  default     = "cluster-autoscaler"
}

variable "helm_chart_name" {
  type        = string
  default     = "cluster-autoscaler"
  }

variable "helm_chart_release_name" {
  type        = string
  default     = "cluster-autoscaler"
  }

variable "fullname_override" {
  type        = string
  default     = "aws-cluster-autoscaler"
 }

variable "helm_chart_version" {
  type        = string
  default     = "9.5.0"
 }

variable "helm_chart_repo" {
  type        = string
  default     = "https://kubernetes.github.io/autoscaler"
  }

variable "namespace" {
  type        = string
  default     = "kube-system"
  }

