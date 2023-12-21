#Creating resources in cluster
module "prometheus_and_grafana" {
  source                        = "../modules/prometheus_and_grafana"
  count = var.installPrometheusandGrafana ? 1 : 0
  helm_chart_prometheus_version = var.helm_chart_prometheus_version
  namespace                     = var.prom_and_graf_namespace
  # priv_hosted_zone_id = var.priv_hosted_zone_id
  client_id = var.client_id

  depends_on = [
    module.consul
  ]

}

# module "consul_efs" {
#   source          = "../modules/efs"
#   count = var.installConsul ? 1 : 0
#   aws_region      = var.aws_region
#   vpc_id          = var.vpc_id
#   client_name     = var.client_name
#   env_ns     = "${var.client_name}-${var.environment}-consul"
#   region_name     = var.region_name
#   cluster_subnets = var.cluster_subnets
#   path = "/consul"
#   owner_gid = 1000
#   owner_uid = 100
#   permissions = 777  
# }

module "consul" {
 source        = "../modules/consul"
 count = var.installConsul ? 1 : 0
 aws_region    = var.aws_region
 consulReplica = var.consulReplica
#  fileSystemID  = module.consul_efs.0.efs_file_system_id
#  accessPointId = module.consul_efs.0.access_point_id
 client_id = var.client_id
#  consul_arn_acm = var.consul_arn_acm
#  priv_hosted_zone_id = var.priv_hosted_zone_id

#  depends_on = [
#    module.consul_efs,
#  ]
}


# #Following components get created per environment mentioned in target_env_ns

# module "efs" {
#   source          = "../modules/efs"
#   count = "${length(var.target_env_ns) }"
#   aws_region      = var.aws_region
#   vpc_id          = var.vpc_id
#   client_name     = var.client_name
#   env_ns     = "${element(var.target_env_ns,count.index)}"
#   region_name     = var.region_name
#   cluster_subnets = var.cluster_subnets
#   path = "/data"
#   owner_gid = 2537
#   owner_uid = 2537
#   permissions = 777  

# }

module "sqs" {
  source          = "../modules/sqs"
  count = "${length(var.target_env_ns)}"
  TA_deadletter_maxReceiveCount = "${element(var.TA_deadletter_maxReceiveCount,count.index)}"
  COMPLETION_deadletter_maxReceiveCount = "${element(var.COMPLETION_deadletter_maxReceiveCount,count.index)}"
  env_ns = "${element(var.target_env_ns,count.index)}"
  sqsFlag = "${element(local.sqsFlag,count.index)}"

}

module "mongodb" {
  source          = "../modules/mongodb"
  count = "${length(var.target_env_ns)}"
  mongodbclusterName = "${element(var.mongodbclusterName,count.index)}"
  mongodbusername = "${element(var.mongodbusername,count.index)}"
  mongodbpassword = "${element(var.mongodbpassword,count.index)}"
  mongodbInstanceClass = "${element(var.mongodbInstanceClass,count.index)}"
  clusterParameterGroupfamilyVersion = "${element(var.clusterParameterGroupfamilyVersion,count.index)}"
  clusterPort = "${element(var.clusterPort,count.index)}"
  client_name = var.client_name
  environment = var.environment
  region_name = var.region_name
  vpc_id = var.vpc_id
  env_ns = "${element(var.target_env_ns,count.index)}"
  cluster_subnets = var.cluster_subnets
  # priv_hosted_zone_id = var.priv_hosted_zone_id
  record_name = "${element(var.record_name,count.index)}"
  mongoFlag = "${element(local.mongoFlag,count.index)}"
  line_of_bussiness = "${var.line_of_bussiness}"
  BillingId = "${var.BillingId}"
  Application = "${var.Application}"


}

module "namespace" {
  count = "${length(var.target_env_ns) }"
  source                        = "../modules/namespace"
  env_ns                     = "${element(var.target_env_ns,count.index)}"
  

}

# module "alb_ingress" {
#   count= "${length(var.target_env_ns) }"
#   source                        = "../modules/alb_ingress"
#   env_ns                     = "${element(var.target_env_ns,count.index)}"
#   acm_arn = "${element(var.acm_arn,count.index)}"
#   priv_hosted_zone_id = var.priv_hosted_zone_id
#   pub_hosted_zone_id = var.pub_hosted_zone_id 
#   envSubdomain = "${element(var.envSubdomain,count.index)}"

#   depends_on = [
#     module.namespace
#   ]
# }

module "postgres" {
  count= "${length(var.target_env_ns) }"
  source                        = "../modules/postgres"
  env_ns                     = "${element(var.target_env_ns,count.index)}"
  cluster_identifier = "${element(var.cluster_identifier,count.index)}"
  db_name = "${element(var.db_name,count.index)}"
  pg_username = "${element(var.pg_username,count.index)}"
  engine_version = "${element(var.engine_version,count.index)}"
  kms_key_id = "${element(var.kms_key_id,count.index)}"
  port = "${element(var.port,count.index)}"
  instance_identifier = "${element(var.instance_identifier,count.index)}"
  instance_class = "${element(var.instance_class,count.index)}"
  client_name = var.client_name
  environment = var.environment
  vpc_id = var.vpc_id
  subnet_ids = var.cluster_subnets
  line_of_bussiness = var.line_of_bussiness
  db_username = "${element(var.db_username,count.index)}"
  schema_name = "${element(var.schema_name,count.index)}"
  postgresFlag = "${element(local.postgresFlag,count.index)}"
  final_snapshot_identifier = "${element(var.final_snapshot_identifier,count.index)}"
  preferred_backup_window = "${element(var.preferred_backup_window,count.index)}"
  preferred_maintenance_window = "${element(var.preferred_maintenance_window,count.index)}"
  skip_final_snapshot = "${element(var.skip_final_snapshot,count.index)}"
  allocated_storage = "${element(var.allocated_storage,count.index)}"
  storage_type = "${element(var.storage_type,count.index)}"
  tags = "${element(var.tags,count.index)}"
  instance_count = "${element(var.instance_count,count.index)}"
  lob = var.lob
  envSubdomain = "${element(var.envSubdomain,count.index)}"
  branch = "${element(var.branch,count.index)}"


 
}





