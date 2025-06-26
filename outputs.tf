output "api_gateway_url" {
  description = "URL to send POST requests to trigger the event pipeline"
  value       = module.event_pipeline.api_gateway_url
}

output "queue_url" {
  description = "SQS Queue URL for monitoring"
  value       = module.event_pipeline.sqs_url
}

output "producer_lambda_name" {
  description = "Producer Lambda function name"
  value       = module.event_pipeline.producer_lambda_name
}

output "consumer_lambda_name" {
  description = "Consumer Lambda function name"
  value       = module.event_pipeline.consumer_lambda_name
}

output "lambda_artifacts_bucket" {
  description = "S3 bucket for Lambda artifacts"
  value       = module.event_pipeline.lambda_artifacts_bucket
}

output "codepipeline_name" {
  description = "Name of the CodePipeline (if GitHub repo is configured)"
  value       = module.event_pipeline.codepipeline_name
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = module.event_pipeline.codebuild_project_name
}

output "codestar_connection_arn" {
  description = "ARN of the CodeStar connection (needs to be activated in AWS Console)"
  value       = module.event_pipeline.codestar_connection_arn
}
