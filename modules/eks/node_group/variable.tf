variable "name" {
    type = string
    description = "EKS Node group name"
  
}

variable "cluster_name" {
    type = string
    description = "EKS Cluster name"
}

variable "capacity_type" {
    type = string
    description = "EKS Nodegroup capacity type" 
    default = "ON_DEMAND"
}

variable "subnet_ids" {
    type = list(string)
    description = "EKS Nodegroup subnet ids"
}

variable "max_size" {
    type = number
    description = "EKS Nodegroup max node size"
}

variable "min_size" {
    type = number
    description = "EKS Nodegroup min node size"
}

variable "desired_size" {
    type = number
    description = "EKS Nodegroup desired node size"
}

variable "environment" {
    type = string
}

variable "instance_type" {
    type = string
    description = "EKS Nodegroup instance types"
  
}

variable "labels" {
    type = map(string)
  
}

variable "tags" {
    type = map(string)
  
}