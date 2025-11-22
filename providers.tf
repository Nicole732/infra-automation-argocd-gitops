terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket = "infra-bucket-11"
    key    = "infra/state2.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
  }
}