
provider "kubernetes" {
  host                   = var.cluster_endpoint //aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate) //base64decode(file("${path.module}/clusterCA.txt"))
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${var.cluster_name}"]
    command     = "aws"
  }
}

provider "helm" {
 kubernetes {
  host                   = var.cluster_endpoint //aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate) //base64decode(file("${path.module}/clusterCA.txt"))
  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"

    args = ["eks", "get-token", "--cluster-name", "${var.cluster_name}"]
  }
  }
}

