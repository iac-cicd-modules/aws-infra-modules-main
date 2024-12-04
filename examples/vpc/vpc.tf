module "vpc" {
  for_each = var.vpcs
  source   = "./vpc"

  name        = var.vpcs[each.key].name
  environment = var.environment
  region      = var.aws_account.region
  vpcs        = var.vpcs
}
