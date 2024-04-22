resource "aws_ecs_cluster" "main" {
  name = "${var.name}-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = var.capacity_provider


}

output "id" {
  value = aws_ecs_cluster.main.id
}

output "name" {
  value = aws_ecs_cluster.main.name
}