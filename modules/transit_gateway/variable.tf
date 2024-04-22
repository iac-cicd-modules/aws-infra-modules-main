variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "account_ids" {
  type    = list(string)
  default = []

}
