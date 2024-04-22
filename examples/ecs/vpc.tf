module "vpc_sample" {
  source                = "../../modules/vpc"
  region                = var.region
  environment           = var.environment
  name                  = "sample"
  vpc_cidr              = "10.132.0.0/16"
  private_subnet_1_cidr = "10.132.0.0/22"
  private_subnet_2_cidr = "10.132.4.0/22"
  private_subnet_3_cidr = "10.132.8.0/22"
  db_subnet_1_cidr      = "10.132.12.0/24"
  db_subnet_2_cidr      = "10.132.13.0/24"
  db_subnet_3_cidr      = "10.132.14.0/24"
  public_subnet_1_cidr  = "10.132.252.0/24"
  public_subnet_2_cidr  = "10.132.253.0/24"
  public_subnet_3_cidr  = "10.132.254.0/24"
}
