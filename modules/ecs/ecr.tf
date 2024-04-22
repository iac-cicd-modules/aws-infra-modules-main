resource "aws_ecr_repository" "main" {
  count                = var.existing_container_registry ? 0 : 1
  name                 = "${var.name}-${var.environment}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

