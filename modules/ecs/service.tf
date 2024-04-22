resource "aws_ecs_service" "main" {
  name            = var.name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.main.id
  desired_count   = var.desired_count
  #launch_type     = "FARGATE"
  force_new_deployment = var.force_new_deployment


  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.main.id]
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer == true ? [1] : []
    content {
      container_name   = var.name
      container_port   = var.port
      target_group_arn = aws_lb_target_group.main[0].arn
    }

  }

  dynamic "capacity_provider_strategy" {
    for_each = var.launch_type == "FARGATE" ? [1] : []
    content {
      capacity_provider = "FARGATE"
      weight            = 100
      base              = var.base
    }
  }
  dynamic "capacity_provider_strategy" {
    for_each = var.launch_type == "FARGATE_SPOT" ? [1] : []
    content {
      capacity_provider = "FARGATE_SPOT"
      weight            = 100
    }
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.launch_type == "BALANCED" ? [1] : []
    content {
      capacity_provider = "FARGATE"
      weight            = var.base
      base              = var.base
    }
  }
  dynamic "capacity_provider_strategy" {
    for_each = var.launch_type == "BALANCED" ? [1] : []
    content {
      capacity_provider = "FARGATE_SPOT"
      weight            = var.weight
    }
  }


  lifecycle {
    create_before_destroy = true
    ignore_changes        = [task_definition, enable_execute_command]
  }

}

resource "aws_security_group" "main" {
  name        = "sg_${var.name}-${var.environment}"
  description = "ECS Service Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

