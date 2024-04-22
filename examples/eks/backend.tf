terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }
  required_version = "> 1.0.0"
}


provider "aws" {

  default_tags {
    tags = {
      builder     = "Terraform"
      company     = "Nami"
      environment = var.environment
    }
  }
  region              = var.region
}

