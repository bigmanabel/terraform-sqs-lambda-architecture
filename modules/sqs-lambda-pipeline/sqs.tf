# SQS Queue for event processing
resource "aws_sqs_queue" "event_queue" {
  name                       = "${var.project_name}-event-queue"
  delay_seconds              = 0
  max_message_size           = 2048
  message_retention_seconds  = 1209600 # 14 days
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 300

  # Dead letter queue configuration
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5
  })

  tags = {
    Name = "${var.project_name}-event-queue"
  }
}

# Dead Letter Queue
resource "aws_sqs_queue" "dlq" {
  name = "${var.project_name}-dlq"

  tags = {
    Name = "${var.project_name}-dlq"
  }
}
