# #EXTRACTING THE DETAILS OF PUBLIC HOSTED ZONE
# data "aws_route53_zone" "public" {
#   zone_id         = var.pub_hosted_zone_id
#   }

# #CREATING ROUTE53 ENTRY FOR PUBLIC LOADBALANCER 
# resource "null_resource" "getIngDNSname-external" {
#   provisioner "local-exec" {
#     command = "kubectl get ing -n kube-system | grep ${var.env_ns}-alb-nginx-public | awk '{print $4}'  > ../modules/alb_ingress/externalDNSName.txt"
#   }
#   depends_on = [time_sleep.wait_30_seconds]
# }

# data "local_file" "ingress-dns-name-external" {
#   filename = "../modules/alb_ingress/externalDNSName.txt"
#   depends_on = [null_resource.getIngDNSname-external]
# }

# #Entry for record_name: <namespace>
# resource "aws_route53_record" "alb_ingress_public" {
#   zone_id = data.aws_route53_zone.public.zone_id
#   name    = "${var.envSubdomain}.${data.aws_route53_zone.public.name}"
#   type    = "CNAME"
#   ttl     = 30
#   records = [trim(data.local_file.ingress-dns-name-external.content,"\n")]

# }

# #Entry for record_name: *.<namespace>
# resource "aws_route53_record" "alb_ingress_public1" {
#   zone_id = data.aws_route53_zone.public.zone_id
#   name    = "*.${var.envSubdomain}.${data.aws_route53_zone.public.name}"
#   type    = "CNAME"
#   ttl     = 30
#   records = [trim(data.local_file.ingress-dns-name-external.content,"\n")]

# }
