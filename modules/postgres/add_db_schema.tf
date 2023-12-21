#Resolving placeholders or schema.sql
data "github_repository_file" "schema" {
  count = var.postgresFlag
  repository          = "gf-${var.lob}-${var.client_name}-${var.envSubdomain}"
  branch              = var.branch
  file                = "schema.sql"
}

data "github_repository_file" "grant" {
  count = var.postgresFlag
  repository          = "gf-${var.lob}-${var.client_name}-${var.envSubdomain}"
  branch              = var.branch
  file                = "grant.sql"
}

# resource "null_resource" "get_repo" {

#   provisioner "local-exec" {
#    command = "git clone -b ${var.branch} https://ps-github2-service-account-wexinc:${local.github_password}@github.com/wexinc/gf-${var.lob}-${var.client_name}-${var.envSubdomain}.git"
#  }
# }

resource "null_resource" "get_repo" {
  count = var.postgresFlag

  triggers = {
    repo_name = data.github_repository_file.grant.0.repository
  }

  provisioner "local-exec" {
   command = "git clone -b ${var.branch} https://ps-github2-service-account-wexinc:${local.github_password}@github.com/wexinc/${self.triggers.repo_name}"
 }

 provisioner "local-exec" {
    when    = destroy
    command = "sudo rm -rf ${self.triggers.repo_name}"
  }
}


data "template_file" "schema" {
  count = var.postgresFlag
  template = data.github_repository_file.schema.0.content
  vars = {
    db_username = "wex_ev_dev_1"
    schema_name = "wex_ev_dev_1"
    db_password = "${local.pg_password}"
    db_name = "${var.db_name}"
  }

  depends_on = [
   aws_rds_cluster_instance.cluster_instances,
   null_resource.get_repo
 ]
}

#Resolving placeholders or grant.sql
data "template_file" "grant" {
  count = var.postgresFlag
  template = data.github_repository_file.grant.0.content
  vars = {
    db_username = "wex_ev_dev_1"
    schema_name = "wex_ev_dev_1"
    db_password = "${local.pg_password}"
    db_name = "${var.db_name}"
  }

  depends_on = [
   aws_rds_cluster_instance.cluster_instances,
   null_resource.get_repo
 ]
}

#Render schema.sql
resource "local_file" "rendered_schema" {
  count = var.postgresFlag
  content  = data.template_file.schema.0.rendered
  filename = "schema.sql"
}

#Render grant.sql
resource "local_file" "rendered_grant" {
  count = var.postgresFlag
  content  = data.template_file.grant.0.rendered
  filename = "grant.sql"
}


#TRIGGERING ANSIBLE PLAYBOOK TO LOAD DDL DML COFIGURATION INTO POSTGRES SERVER
resource "null_resource" "for_rds" {
  count = var.postgresFlag
  #path will be ./gf-ifcs-${env_ns}/schema.sql
  provisioner "local-exec" {
   command = " ansible-playbook ../modules/postgres/ansible.yaml -e 'lob=${var.lob} client_name=${var.client_name} envSubdomain=${var.envSubdomain} db_name=${var.db_name} master_user=${var.pg_username} db_user=${var.db_username} host=${aws_rds_cluster.postgresql.0.endpoint} password=${local.pg_password} schema_name=${var.schema_name}' "
 }

 depends_on = [
   local_file.rendered_schema,
   local_file.rendered_grant
 ]

}