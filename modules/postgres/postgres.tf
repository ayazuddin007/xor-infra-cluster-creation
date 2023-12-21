#CREATING POSTGRES CLUSTER AND INSTANCE
data "aws_secretsmanager_secret_version" "getSecret" {
  secret_id = "git_jfrog_credentials"
}

locals {
  pg_password = jsondecode(data.aws_secretsmanager_secret_version.getSecret.secret_string)["pg_password"]
  github_password = jsondecode(data.aws_secretsmanager_secret_version.getSecret.secret_string)["github_password"]

}

resource "aws_rds_cluster" "postgresql" {
  count = var.postgresFlag
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-postgresql"
  database_name           = var.db_name
  master_username         = var.pg_username
  master_password         = local.pg_password
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.postgres_param.0.id
  db_instance_parameter_group_name = aws_db_parameter_group.postgres_param_instance.0.id
  db_subnet_group_name = "${aws_db_subnet_group.db-sng.0.name}"
  engine_version = var.engine_version
  kms_key_id = var.kms_key_id
  port = var.port
  storage_encrypted = true
  vpc_security_group_ids = [aws_security_group.pg_sg.0.id]
  # backtrack_window = 0
  # backup_retention_period = 1
  # copy_tags_to_snapshot = false
  # deletion_protection = false
  # enabled_cloudwatch_logs_exports = "error"
  final_snapshot_identifier = var.final_snapshot_identifier
  preferred_backup_window = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  skip_final_snapshot = var.skip_final_snapshot
  tags = "${merge(var.tags,
   {        
         Name = "${var.cluster_identifier}"        
   }

  )}"
 
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count = "${var.postgresFlag * var.instance_count}"
  identifier         = "${var.instance_identifier}-${count.index}"
  cluster_identifier = aws_rds_cluster.postgresql.0.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.postgresql.0.engine
  engine_version     = aws_rds_cluster.postgresql.0.engine_version
  db_subnet_group_name = aws_db_subnet_group.db-sng.0.name
  db_parameter_group_name = aws_db_parameter_group.postgres_param_instance.0.id
 

  tags = "${merge(var.tags,
   {        
         Name = "${var.instance_identifier}-${count.index}"        
   }

  )}"

}























