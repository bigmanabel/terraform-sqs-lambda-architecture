# CloudWatch Log Group for Producer Lambda
resource "aws_cloudwatch_log_group" "producer_lambda_logs" {
  name              = "/aws/lambda/${var.project_name}-producer"
  retention_in_days = 14
}

# CloudWatch Log Group for Consumer Lambda
resource "aws_cloudwatch_log_group" "consumer_lambda_logs" {
  name              = "/aws/lambda/${var.project_name}-consumer"
  retention_in_days = 14
}

# CloudWatch Log Group for API Gateway
resource "aws_cloudwatch_log_group" "api_logs" {
  name              = "/aws/apigateway/${var.project_name}-api"
  retention_in_days = 14
}
