
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"   # specify version constraint
    }
  }
}

#Interface to intract with cloud provider
provider "aws" { 
  region = "eu-north-1" 
}
