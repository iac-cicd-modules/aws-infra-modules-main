module "cluster" {
  source            = "../../../modules/ecs_cluster"
  name              = "ecs"
  environment       = var.environment
  capacity_provider = ["FARGATE", "FARGATE_SPOT"]
}

module "ecs-1" {
  cluster_id           = module.cluster.id
  source               = "../../../modules/ecs"
  name                 = "api"
  environment          = var.environment
  force_new_deployment = false
  launch_type          = "FARGATE_SPOT"

  // Configuração da Task Definition
  port               = 80
  desired_count      = 1
  cpu                = 512
  memory             = 1024
  log_retention_days = 7
  s3_path            = "ecs-envs/homolog/file.env"

  // Configuração da Rede
  region           = var.region
  vpc_id           = var.vpc_id
  subnets          = var.private_subnets
  assign_public_ip = false

  // Configuração do Load Balancer
  load_balancer = true
  listener_arn  = module.alb_main.listener_arn
  host_header   = ["sample.example.com"]
  health_check  = "/"

  // Configuração do Pipeline
  setup_pipeline  = true
  bucket_location = "codepipeline-sample-s3"
  connection_arn  = var.connection_arn
  repository      = "kxc-tecnologia/sample-repo"
  branch          = "main"
  codebuild_name  = module.codebuild_1.name
  cluster_name    = module.cluster.name
  docker_path     = "./Dockerfile"
}
