resource "aws_security_group" "main" {
  description = "eks-cluster-${var.name}-${var.environment}"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = "0"
    protocol        = "tcp"
    self            = "false"
    to_port         = "65535"
  }

  name = "eks-cluster-${var.name}-${var.environment}"

  tags = {
    Name = "eks-cluster-${var.name}-${var.environment}"
  }


  vpc_id = var.vpc_id
}