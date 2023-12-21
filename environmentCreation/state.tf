terraform {
         backend "s3" {
             key    = "infrastructure/environmentCreation/terraform.tfstate"
             encrypt        = true
         }
}