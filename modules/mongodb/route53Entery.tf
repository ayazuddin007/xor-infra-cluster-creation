#CREATING ROUTE53 ENTRY FOR ACCESSING DB
# data "aws_route53_zone" "selected" {
#   count = var.mongoFlag
#   zone_id         = var.priv_hosted_zone_id
#   private_zone = true
#   }

# resource "aws_route53_record" "mongodbEntry" {
#   count = var.mongoFlag
#   zone_id = data.aws_route53_zone.selected.0.zone_id
#   name    = "${var.record_name}.${data.aws_route53_zone.selected.0.name}"
#   type    = "CNAME"
#   ttl     = 30
#   records = [aws_docdb_cluster.mongodb_cluster.0.reader_endpoint ]
# }
