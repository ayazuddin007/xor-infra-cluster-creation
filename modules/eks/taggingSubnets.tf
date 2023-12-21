#TAGGING PUBLIC AND PRIVATE SUBNETS
resource "aws_ec2_tag" "private_subnet_cluster_tag" {
  count           = length(var.cluster_subnets)
  resource_id = element(var.cluster_subnets, count.index)
  key         = "kubernetes.io/cluster/${local.cluster-name}"
  value       = "shared"
}

resource "aws_ec2_tag" "private_subnet_elb_tag" {
  count           = length(var.cluster_subnets)
  resource_id = element(var.cluster_subnets, count.index)
  key = "kubernetes.io/role/internal-elb"
  value = 1

}


data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "Public"
  }
}
resource "aws_ec2_tag" "public_subnet_cluster_tag" {
  count      = "${length(data.aws_subnets.public.ids)}"
  resource_id = "${element(data.aws_subnets.public.ids,count.index)}"
  key         = "kubernetes.io/cluster/${local.cluster-name}"
  value       = "owned"
}

resource "aws_ec2_tag" "public_subnet_elb_tag" {
  count      = "${length(data.aws_subnets.public.ids)}"
  resource_id = "${element(data.aws_subnets.public.ids,count.index)}"
  key = "kubernetes.io/role/elb"
  value = 1

}