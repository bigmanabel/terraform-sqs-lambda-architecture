# ==============================================================================
# SQS-Lambda Pipeline Module
# ==============================================================================
#
# This module creates a complete serverless pipeline architecture with:
# - AWS SQS queues for event processing
# - Lambda functions (producer and consumer) deployed via CodePipeline
# - API Gateway for HTTP triggers
# - CodePipeline/CodeBuild for CI/CD from GitHub
# - CloudWatch logs and monitoring
# - IAM roles and policies
# - S3 bucket for artifacts
#
# Lambda function code is managed in a separate repository and deployed
# automatically through CodePipeline when code changes are pushed to GitHub.
#
# ==============================================================================
