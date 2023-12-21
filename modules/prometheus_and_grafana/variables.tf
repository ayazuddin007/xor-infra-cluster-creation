variable "namespace" {
  type        = string
  default     = "monitoring"
  description = "Kubernetes namespace to deploy Monitoring stack Helm charts."
}
variable "helm_chart_prometheus_release_name" {
  type        = string
  default     = "prometheus"
  description = "Prometheus Helm release name"
}

variable "helm_chart_prometheus_name" {
  type        = string
  default     = "kube-prometheus-stack"
  description = "Prometheus Helm chart name to be installed"
}

variable "helm_chart_prometheus_version" {
  type        = string
  default     = "14.9.0"
  description = "Prometheus Helm chart version."
}

variable "helm_chart_prometheus_repo" {
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
  description = "Prometheus repository name."
}

# variable "priv_hosted_zone_id" {
#   type = string
# }

variable "client_id" {
  type = string
}
