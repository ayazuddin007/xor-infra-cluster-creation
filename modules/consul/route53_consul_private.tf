#EXTRACTING DETAILS OF PRIVATE HOSTED ZONE
# data "aws_route53_zone" "private" {
#   zone_id         = var.priv_hosted_zone_id
#   private_zone = true
# }

# resource "time_sleep" "wait_30_seconds" {
#   depends_on = [
#     kubernetes_ingress.consul_internal_ingress
#   ]

#   create_duration = "30s"
# }

# #GETTING THE LOADBALACER URL AND SAVING IT IN A FILE
# resource "null_resource" "getIngDNSname-consul-internal" {
#   provisioner "local-exec" {
#     command = "kubectl get ing -n kube-system | grep consul-and-grafana-alb-nginx-private | awk '{print $4}'  > ../modules/consul/consulDNSName.txt"
#   }
#   depends_on = [time_sleep.wait_30_seconds]
# }

# #EXTRACTING THE VALUE STORED BY ABOVE COMMAND
# data "local_file" "ingress-consul-dns-name-internal" {
#   filename = "../modules/consul/consulDNSName.txt"
#   depends_on = [null_resource.getIngDNSname-consul-internal]
# }

# #Entry for record_name: CONSUL.<CLIENT_ID>.<ZONE_NAME>
# resource "aws_route53_record" "alb_consul_ingress_private" {
#   zone_id = data.aws_route53_zone.private.zone_id
#   name    = "consul.${var.client_id}.${data.aws_route53_zone.private.name}"
#   type    = "CNAME"
#   ttl     = 30
#   records = [trim(data.local_file.ingress-consul-dns-name-internal.content,"\n")]

# }