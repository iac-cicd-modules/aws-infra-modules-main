resource "aws_lb_target_group" "main" {
  count       = var.load_balancer ? 1 : 0
  name        = "${var.name}-${var.environment}"
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.health_check
    matcher             = "200-499"
    interval            = 60
    unhealthy_threshold = 5
  }


  tags = {
    Name = "tg-${var.name}-${var.environment}"
  }
}


resource "aws_lb_listener_rule" "main" {
  count        = var.load_balancer ? 1 : 0
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[0].arn
  }

  condition {
    host_header {
      values = var.host_header
    }
  }
}