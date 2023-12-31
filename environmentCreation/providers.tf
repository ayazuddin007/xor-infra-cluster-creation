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

provider "github" {
  token = local.github_password
  owner = "ps-github2-service-account-wexinc"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "${data.aws_eks_cluster.eks.id}"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "${data.aws_eks_cluster.eks.id}"
}


data "aws_availability_zones" "available" {}

# Not required: currently used in conjunction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}
