variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

data "aws_subnets" "allsubnetIds" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


variable "client_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region_name" {
  type = string
}

variable "cluster_subnets" {
  type = list(any)
}

variable "Node_group_subnets" {
  type = list(any)
}

variable "Node_group_scaling_config_desired_size" {
  type = number
}

variable "Node_group_scaling_config_max_size" {
  type = number
}

variable "Node_group_scaling_config_min_size" {
  type = number
}

variable "Node_group_instance_type" {
  type = string
}

variable "Node_group_ami_id" {
  type = string
}

variable "consulReplica" {
  default = "3"
  
}
variable "Cluster_version" {
  type =  string
}

variable "helm_chart_prometheus_version" {
  type        = string
  default     = "14.9.0"
  description = "Prometheus Helm chart version."
}

variable "prom_and_graf_namespace" {
  type        = string
  default     = "monitoring"
  description = "Kubernetes namespace to deploy Monitoring stack Helm charts."
}

variable "helm_chart_datadog_version" {
  type        = string
  default     = "2.31.1"
  description = "Datadog Helm chart version."
}

variable "datadog_namespace" {
  type        = string
  default     = "datadog"
  description = "Kubernetes namespace to deploy Datadog agent Helm chart."
}

variable "vpc_cidr" {
  type = string
}

variable "Nodegroup_ebs_volume" {
  type = number
}

variable "acm_arn" {
  type = list
}



variable "TA_deadletter_maxReceiveCount" {
  type = list
}

variable "COMPLETION_deadletter_maxReceiveCount" {
  type = list
}

variable "mongodbclusterName" {
  type = list
}

variable "mongodbusername" {
  type = list
}

variable "mongodbpassword" {
  type = list
}

variable "mongodbInstanceClass" {
  type = list
}

variable "clusterParameterGroupfamilyVersion" {
  type = list
}

variable "clusterPort" {
  type = list
}

variable "installConsul" {
  type = bool
}

variable "createSQSqueue" {
  type = list
}

variable "installPrometheusandGrafana" {
  type = bool
}

variable "installDataDog" {
  type = bool
}


variable "createMongodb" {
  type = list
}


variable "record_name" {
  type = list
}

variable "target_env_ns" {
  type = list
}

variable "envSubdomain" {
   type = list
}

# variable "priv_hosted_zone_id" {
#   type = string
# }

variable "pub_hosted_zone_id" {
  type = string
}

variable "client_id" {
  type = string
}

# variable "consul_arn_acm" {
#   type = string
# }

variable "line_of_bussiness" {
  type = string
}

variable "BillingId" {
  type = string
}

variable "Owner" {
  type = string
}

variable "Application" {
  type = string
}

#postgre variable
variable "cluster_identifier"{
    type = list
}

variable "db_name" {
    type = list
}

variable "pg_username"{
    type = list

}

variable "engine_version"{
    type = list
}

variable "kms_key_id"{
    type = list
}

variable "port"{
    type = list
}

variable "instance_identifier"{
    type = list
}

variable "instance_class"{
    type = list
}

variable "db_username"{
    type = list
}

variable "schema_name"{
    type = list
}

variable "createPostgres" {
  type = list
}

variable "instance_count"{
    type = list
}

variable "tags"{
    type = list
}

variable "final_snapshot_identifier"{
    type = list
}

variable "preferred_backup_window"{
    type = list
}

variable "preferred_maintenance_window"{
    type = list
}

variable "skip_final_snapshot"{
    type = list
}

variable "allocated_storage"{
    type = list
}

variable "storage_type"{
    type = list
}

variable "lob"{
    type = string
}

variable "branch"{
    type = list
}
