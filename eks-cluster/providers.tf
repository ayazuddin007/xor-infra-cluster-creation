terraform {
  required_version = ">= 0.12"
  required_providers {
    helm = {
      version = ">= 1.3.2"
    }
 
  }
}

provider "aws" {
  region = var.aws_region
  #tags to add on every resource created by this script
  default_tags {
    tags = {
      Owner = "gl-wfl-devops@gmail.com"
    } 
  
  }
}



data "aws_availability_zones" "available" {}

# Not required: currently used in conjunction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}
