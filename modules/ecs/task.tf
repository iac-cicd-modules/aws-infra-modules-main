resource "aws_ecs_task_definition" "main" {
  family                   = "${var.name}-${var.environment}"
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.main.arn
  task_role_arn            = aws_iam_role.main.arn
  container_definitions = jsonencode([{
    name      = var.name
    image     = var.existing_container_registry == true ? var.image_uri : aws_ecr_repository.main[0].repository_url
    essential = true
    environmentFiles = [
      {
        "value" : "arn:aws:s3:::${var.s3_path}",
        "type" : "s3"
      }
    ]
    portMappings = [
      {
        containerPort = var.port
        hostPort      = var.port
      }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "${aws_cloudwatch_log_group.log_group.name}"
        awslogs-region        = "${var.region}"
        awslogs-stream-prefix = "${var.name}-${var.environment}"

      }
    }
  }])

}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.name}-${var.environment}"
  retention_in_days = var.log_retention_days
}

resource "aws_iam_role" "main" {
  name = "${var.name}-${var.environment}-IAM-Role"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
 {
   "Effect": "Allow",
   "Principal": {
     "Service": ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
   },
   "Action": "sts:AssumeRole"
  }
  ]
 }
EOF
}

