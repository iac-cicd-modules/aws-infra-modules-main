variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "vpcs" {
  type = map(object({
    cidr_block = string
    name       = string
    private_subnets = map(object({
      cidr_block = string
      name       = string
      az         = string
    }))
    public_subnets = map(object({
      cidr_block = string
      name       = string
      az         = string
    }))
  }))
  description = "Map of VPC configurations including private and public subnets"
}

