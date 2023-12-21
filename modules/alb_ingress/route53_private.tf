
# #EXTRACTING THE DETAILS OF PRIVATE HOSTED ZONE
# data "aws_route53_zone" "private" {
#   zone_id         = var.priv_hosted_zone_id
#   private_zone = true
# }

# resource "time_sleep" "wait_30_seconds" {
#   depends_on = [
#     kubernetes_ingress.external_ingress, 
#     kubernetes_ingress.internal_ingress,
#   ]

#   create_duration = "30s"
# }

# #CREATING ROUTE53 ENTRY FOR PRIVATE LOADBALANCER 
# resource "null_resource" "getIngDNSname-internal" {
#   provisioner "local-exec" {
#     command = "kubectl get ing -n kube-system | grep ${var.env_ns}-alb-nginx-private | awk '{print $4}'  > ../modules/alb_ingress/internalDNSName.txt"
#   }
#   depends_on = [time_sleep.wait_30_seconds]
# }

# data "local_file" "ingress-dns-name-internal" {
#   filename = "../modules/alb_ingress/internalDNSName.txt"
#   depends_on = [null_resource.getIngDNSname-internal]
# }

# #Entry for record_name: <namespace>
# resource "aws_route53_record" "alb_ingress_private" {
#   zone_id = data.aws_route53_zone.private.zone_id
#   name    = "${var.envSubdomain}.${data.aws_route53_zone.private.name}"
#   type    = "CNAME"
#   ttl     = 30
#   records = [trim(data.local_file.ingress-dns-name-internal.content,"\n")]

# }

# #Entry for record_name: *<namespace>
# resource "aws_route53_record" "alb_ingress_private1" {
#   zone_id = data.aws_route53_zone.private.zone_id
#   name    = "*.${var.envSubdomain}.${data.aws_route53_zone.private.name}"
#   type    = "CNAME"
#   ttl     = 30
#   records = [trim(data.local_file.ingress-dns-name-internal.content,"\n")]

# }

