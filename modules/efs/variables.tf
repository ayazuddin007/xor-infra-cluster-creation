variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type    = string
}

data "aws_subnets" "allsubnetIds" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


variable "client_name" {
  type    = string
}



variable "region_name" {
  type = string  
}

variable "cluster_subnets" {
  type = list  
}

variable "env_ns" {
  type = string  
}


variable "owner_gid" {
  type = number

}

variable "owner_uid" {
  type = number  
}

variable "permissions" {
  type = number  
}


variable "path" {
  type = string  
}