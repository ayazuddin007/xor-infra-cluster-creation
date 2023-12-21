variable "mongodbclusterName" {
  type = string
}

variable "mongodbusername" {
  type = string
}

variable "mongodbpassword" {
  type = string
}

variable "mongodbInstanceClass" {
  type = string
}

variable "clusterParameterGroupfamilyVersion" {
  type = string
}

variable "clusterPort" {
  type = number
}

variable "cluster_subnets" {
  type = list(any)
}

variable "client_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "env_ns" {
  type = string
}



variable "region_name" {
  type = string
}

# variable "priv_hosted_zone_id" {
#   type = string
# }
variable "record_name" {
  type = string
}

variable "mongoFlag" {
  type = number
}

variable "line_of_bussiness" {
  type = string
}

variable "BillingId" {
  type = string
}

variable "Application" {
  type = string
}
