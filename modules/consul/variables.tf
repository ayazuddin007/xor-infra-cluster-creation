variable "aws_region" {
  type = string
}

variable "consulReplica" {
  default = "1"
}


# variable "fileSystemID" {
#   type = string
# }

# variable "accessPointId" {
#   type = string
# }

variable "consul_chart_version" {
  type = string
  default = "0.31.1"
}

variable "namespace" {
  type = string
  default     = "consul"
  description = "Kubernetes namespace to deploy consul Helm chart."  
}

variable "helm_chart_consul_release_name" {
  type        = string
  default     = "consul"
  description = "consul Helm release name"
}

variable "helm_chart_name" {
  type        = string
  default     = "consul"
  description = "consul Helm chart name to be installed"
}

variable "helm_chart_consul_repo" {
  type        = string
  default     = "https://helm.releases.hashicorp.com"
  description = "consul repository name."
}

variable "client_id" {
  type = string
}

# variable "consul_arn_acm" {
#   type = string
# }

# variable "priv_hosted_zone_id" {
#   type = string
# }
