variable "namespace" {
  type        = string
  default     = "datadog"
  description = "Kubernetes namespace to deploy datadog agents helm chart."
}
variable "helm_chart_datadog_release_name" {
  type        = string
  default     = "datadog-agent"
  description = "Datadog agent release name"
}

variable "helm_chart_datadog_name" {
  type        =  string
  default     = "datadog"
  description = "datadog Helm chart name to be installed"
}

variable "helm_chart_datadog_version" {
  type        = string
  default     = "2.31.1"
  description = "datadog Helm chart version."
}

variable "helm_chart_datadog_repo" {
  type        = string
  default     = "https://helm.datadoghq.com"
  description = "datadog repository name."
}

variable "datadog_api_key" {
  type = string
  default = ""
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  type = string
  default = ""
  description = "Datadog Application Key"
}