#CREATING PARAMETER GROUP
resource "aws_docdb_cluster_parameter_group" "parameter_group" {
  count = var.mongoFlag
  family      = "${var.clusterParameterGroupfamilyVersion}"
  name        = "${var.client_name}-${var.env_ns}-${var.region_name}-cluster-parameter-group"
  description = "docdb cluster parameter group"

  parameter {
    name  = "tls"
    value = "disabled"
  }

}