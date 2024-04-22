module "codebuild_1" {
  source       = "../../../modules/codebuild"
  name         = "ecs-build"
  account_id   = var.account_id
  region       = var.region
  compute_type = "BUILD_GENERAL1_MEDIUM"
}