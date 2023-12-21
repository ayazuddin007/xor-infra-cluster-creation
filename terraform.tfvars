client_name                            = "xor"
lob                                    = "cis"
client_id                              = "xor"
environment                            = "dev"
region_name                            = "virginia"
cluster_subnets                        = ["subnet-0804dc3fe5d3143db", "subnet-0036887c9251be695", "subnet-023493250b6ef4664"]
Node_group_subnets                     = ["subnet-0804dc3fe5d3143db", "subnet-0036887c9251be695"]
vpc_id                                 = "vpc-0ca2a6728d27416c7"
aws_region                             = "us-east-1"
Node_group_ami_id                      = "ami-01a09362cdb8f50b3"
Node_group_scaling_config_desired_size = 2
Node_group_scaling_config_max_size     = 4
Node_group_scaling_config_min_size     = 2
Node_group_instance_type               = "t2.medium"
Nodegroup_ebs_volume                   = 200
consulReplica                          = "1"
helm_chart_prometheus_version          = "14.9.0"
prom_and_graf_namespace                = "monitoring"
helm_chart_datadog_version             = "2.31.1"
datadog_namespace                      = "datadog"
Cluster_version                        = "1.20"
clusterRepoName                        = "Cluster-creation"
vpc_cidr = "10.97.40.0/22"

#FOLLOWING VARIABLES ARE IN LIST FORMAT WHERE EACH VALUE CORRESPONDS TO ONE NAMESPACE/ENVIRONMENT 
acm_arn = ["arn:aws:acm:us-east-1:462221880066:certificate/0f883f73-c639-4fcd-bd91-7e633c4afbd4"]
TA_deadletter_maxReceiveCount = [3]
COMPLETION_deadletter_maxReceiveCount = [3]
mongodbclusterName = ["xor-test-cluster"]
mongodbusername = ["docdbadmin"]
mongodbpassword = ["abcdefghitjkl"]
mongodbInstanceClass = ["db.t3.medium"]
clusterParameterGroupfamilyVersion = ["docdb4.0"]
clusterPort = [27017]
priv_hosted_zone_id = "Z19XV9TFQ5KD2A"
pub_hosted_zone_id = "Z1GJ4KWMJ71ADZ"
record_name = ["xordocdb1.testing"]
target_env_ns = ["env-dev"]
envSubdomain = ["dev-test"]
consul_arn_acm = "arn:aws:acm:us-east-1:462221880066:certificate/0f883f73-c639-4fcd-bd91-7e633c4afbd4"
#variables for postgres db
cluster_identifier = ["test"]
db_name = ["pgditxorev"]
pg_username = ["cloudadmin"]
engine_version = ["13.3"]
kms_key_id = ["arn:aws:kms:us-east-1:462221880066:key/fcf19cc8-31e0-4a81-b1ce-811a8d2c2645"]
port = [5432]
instance_identifier = ["testinstance"]
instance_class = ["db.r5.large"]
db_username = ["xor_env_dev_1"]
schema_name = ["xor_env_dev_1"]
instance_count = [1]
final_snapshot_identifier = ["name-of-final-snapshot"]
preferred_backup_window = ["07:00-09:00"]
preferred_maintenance_window = ["wed:01:30-wed:02:00"]
skip_final_snapshot = ["true"]
allocated_storage = [10]
storage_type = ["io1"]
branch = ["main"] #branch of environment specific repository

tags = [
    {
         LOB = "cis"
         Environment = "dev"
         Compliance = "None"
         DataClass = "Internal"
         Role = "Primary"
         "aws-service-power-control" = "na"
         Project = "PostgresMigration"
  }
]

#Flags for creating components per environment
createSQSqueue = [false]    
createMongodb = [false]
createPostgres = [false]


#Flags for creating componenets in cluster
installConsul = true
installPrometheusandGrafana = true     #set to false for higher environments such as uat, prod, stages
installDataDog = false # set to false for lower environments. It should be true for only higher environments like PROD, STAGE, UAT

#Following variables are for creating tags
line_of_bussiness= "cis"
BillingId = "xoriant"
Owner = "xoriant"
Application = "cis"





