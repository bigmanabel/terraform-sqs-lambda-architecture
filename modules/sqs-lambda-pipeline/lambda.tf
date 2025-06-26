# Producer Lambda Function (code deployed via CodePipeline)
resource "aws_lambda_function" "producer" {
  s3_bucket     = aws_s3_bucket.lambda_artifacts.bucket
  s3_key        = "producer.zip"
  function_name = "${var.project_name}-producer"
  role          = aws_iam_role.producer_lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 30

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.event_queue.id
    }
  }

  # Ignore changes to source code since CodePipeline manages deployments
  lifecycle {
    ignore_changes = [
      source_code_hash,
      s3_object_version,
    ]
  }

  depends_on = [
    aws_iam_role_policy.producer_lambda_policy,
    aws_cloudwatch_log_group.producer_lambda_logs,
  ]
}

# Consumer Lambda Function (code deployed via CodePipeline)
resource "aws_lambda_function" "consumer" {
  s3_bucket     = aws_s3_bucket.lambda_artifacts.bucket
  s3_key        = "consumer.zip"
  function_name = "${var.project_name}-consumer"
  role          = aws_iam_role.consumer_lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 30

  # Ignore changes to source code since CodePipeline manages deployments
  lifecycle {
    ignore_changes = [
      source_code_hash,
      s3_object_version,
    ]
  }

  depends_on = [
    aws_iam_role_policy.consumer_lambda_policy,
    aws_cloudwatch_log_group.consumer_lambda_logs,
  ]
}

# SQS Event Source Mapping for Consumer Lambda
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.event_queue.arn
  function_name    = aws_lambda_function.consumer.arn
  batch_size       = 1
  enabled          = true
}

# Lambda Permission for API Gateway
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.producer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
