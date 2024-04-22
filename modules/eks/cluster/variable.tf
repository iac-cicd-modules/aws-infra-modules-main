variable "name" {
    type = string
    description = "EKS Cluster name"
  
}

variable "k8s_version" {
    type = string
    description = "EKS k8s version"
  
}

variable "endpoint_private_access" {
    type = bool
    default = true
    description = "Enable EKS Cluster endpoint private access"
}

variable "endpoint_public_access" {
    type = bool
    default = true
    description = "Enable EKS Cluster endpoint public access"
}

variable "subnet_ids" {
    type = list(string)
    description = "EKS Cluster subnets"
}

variable "log_options" {
    type = list
    default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    description = "Enable EKS Cloudwatch logs for EKS components"
}

variable "log_retention" {
    type = number
    default = 7
    description = "Cloudwatch logs retention days"
}

variable "public_access_cidrs" {
    type = list
    default = ["0.0.0.0/0"]
    description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled"
  
}

variable "environment" {
    type = string

  
}

variable "vpc_id" {
    type = string
    description = "VPC id"
}

variable "region" {
    type = string
    description = "AWS Region"
}

variable "eks_cluster_addons" {
    type = any
    default = []
}

