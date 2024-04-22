module "alb_main" {
  source          = "../../modules/alb"
  alb_name        = "sample"
  internal        = false
  environment     = var.environment
  vpc_id          = module.vpc_sample.vpc_id
  subnets         = module.vpc_sample.public_subnets
  certificate_arn = "arn:aws:acm:us-east-1:123456789120:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
