resource "aws_iam_role_policy" "main" {
  name   = "policy-${var.name}-${var.environment}"
  role   = aws_iam_role.main.id
  policy = var.custom_policy
}