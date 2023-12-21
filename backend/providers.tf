terraform {
  required_version = ">= 0.12"
  required_providers {
    helm = {
      version = ">= 1.3.2"
    }
 
  }
}

provider "aws" {
  region = var.region
  #tags to add on every resource created by this script
  default_tags {
    tags = {
      Owner = "gl-wfl-devops@gmail.com"
    } 
  
  }
}
