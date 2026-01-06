# This contains the versions of the provider plugins and the version of deploy infra resources 

terraform {
  required_version = ">=1.14.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}