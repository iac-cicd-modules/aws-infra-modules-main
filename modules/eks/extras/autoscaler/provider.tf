terraform {

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}


provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = var.cluster_ca_certificate
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${var.cluster_name}"]
    command     = "aws"
  }
}

provider "helm" {
 kubernetes {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = var.cluster_ca_certificate
  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"
    args = ["eks", "get-token", "--cluster-name", "${var.cluster_name}"]
  }
  }
}

