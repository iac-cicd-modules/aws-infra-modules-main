variable "subnets" {
  type        = list(string)
  description = "List of subnets to attach"
}

variable "tgw_id" {
  type        = string
  description = "Transit Gateway ID"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to attach"
}

variable "environment" {
  type = string

}