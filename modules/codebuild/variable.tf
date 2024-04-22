variable "name" {
  type        = string
  description = "Codebuild name"

}

variable "account_id" {
  type    = string
  default = null

}

variable "region" {

}

variable "compute_type" {
  type = string
  default = "BUILD_GENERAL1_SMALL"
  
}