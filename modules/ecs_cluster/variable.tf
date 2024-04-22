variable "name" {
  type        = string
  description = "ECS Cluster Name"
}

variable "environment" {
  type = string
}

variable "capacity_provider" {
  type    = list(string)
  default = ["FARGATE", "FARGATE_SPOT"]

}