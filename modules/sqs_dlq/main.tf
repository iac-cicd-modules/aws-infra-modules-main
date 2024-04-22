resource "aws_sqs_queue" "main" {
  name                      = var.name
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.main_dlq.arn
    maxReceiveCount     = var.max_receive_count
  })

  depends_on = [aws_sqs_queue.main_dlq]
}

resource "aws_sqs_queue" "main_dlq" {
  name                      = "${var.name}-dlq"
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
}