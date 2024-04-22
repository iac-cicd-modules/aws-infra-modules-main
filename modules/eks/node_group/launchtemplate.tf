resource "aws_launch_template" "main" {
  name = "${var.name}-${var.environment}"

  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"

    tags = var.tags
  }


}