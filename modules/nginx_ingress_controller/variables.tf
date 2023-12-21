variable "aws_region" {
  type = string
}

variable "ClusterName" {
  type = string
}

variable "helm_chart_name" {
  type        = string
  default     = "ingress-nginx"
  }

variable "helm_chart_release_name" {
  type        = string
  default     = "ingress-nginx"
  }

variable "helm_chart_version" {
  type        = string
  default     = "3.36.0"
 }

variable "helm_chart_repo" {
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
  }

variable "namespace" {
  type        = string
  default     = "kube-system"
}

variable "controller_service_type" {
  type        = string
  default     = "NodePort"
}

variable "controller_service_externalTrafficPolicy" {
  type        = string
  default     = "Local"
}

variable "controller_config_server_tokens" {
  type        = bool
  default     = false
}

variable "controller_config_use_proxy_protocol" {
  type        = bool
  default     = false
}
variable "controller_config_compute_full_forwarded_for" {
  type        = bool
  default     = true
}
variable "controller_config_use_forwarded_headers" {
  type        = bool
  default     = true
}

variable "metrics_enabled" {
  type        = bool
  default     = true
}

