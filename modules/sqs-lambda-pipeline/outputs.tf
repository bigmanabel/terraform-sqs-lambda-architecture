output "api_gateway_url" {
  description = "Invoke URL for the API Gateway endpoint"
  value       = "${aws_apigatewayv2_api.api.api_endpoint}/prod/event"
}

output "sqs_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.event_queue.id
}

output "producer_lambda_name" {
  description = "Name of the producer Lambda function"
  value       = aws_lambda_function.producer.function_name
}

output "consumer_lambda_name" {
  description = "Name of the consumer Lambda function"
  value       = aws_lambda_function.consumer.function_name
}

output "lambda_artifacts_bucket" {
  description = "S3 bucket for Lambda artifacts"
  value       = aws_s3_bucket.lambda_artifacts.bucket
}

output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.lambda_pipeline.name
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.lambda_build.name
}

output "codestar_connection_arn" {
  description = "ARN of the CodeStar connection (needs to be activated in AWS Console)"
  value       = aws_codestarconnections_connection.github.arn
}
