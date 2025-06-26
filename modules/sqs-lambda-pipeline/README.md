# SQS Lambda Pipeline Module

This Terraform module creates a serverless event-driven architecture using AWS
services. The resources are organized into separate files by AWS service for
better maintainability and clarity.

## File Organization

| File              | Purpose                           | Resources                              |
| ----------------- | --------------------------------- | -------------------------------------- |
| `main.tf`         | Module documentation and overview | Comments only                          |
| `variables.tf`    | Input variables                   | Variable definitions                   |
| `outputs.tf`      | Output values                     | Output definitions                     |
| `apigateway.tf`   | API Gateway resources             | HTTP API, stages, integrations, routes |
| `cloudwatch.tf`   | CloudWatch resources              | Log groups for Lambda and API Gateway  |
| `codebuild.tf`    | CodeBuild resources               | Build project for Lambda functions     |
| `codepipeline.tf` | CodePipeline resources            | Pipeline and CodeStar connection       |
| `iam.tf`          | IAM resources                     | Roles and policies for all services    |
| `lambda.tf`       | Lambda resources                  | Functions, event mappings, permissions |
| `s3.tf`           | S3 resources                      | Artifact bucket for Lambda deployments |
| `sqs.tf`          | SQS resources                     | Event queue and dead letter queue      |

## Architecture

```
GitHub → CodePipeline → CodeBuild → S3 → Lambda Functions
                                          ↓
Client → API Gateway → Lambda (Producer) → SQS Queue → Lambda (Consumer)
```

## Resource Dependencies

### Core Infrastructure

- SQS queues (event queue and DLQ)
- S3 bucket for Lambda artifacts
- CloudWatch log groups

### Lambda Functions

- IAM roles and policies
- Lambda functions (producer and consumer)
- Event source mapping (SQS → Consumer Lambda)
- API Gateway permission (Producer Lambda)

### CI/CD Pipeline

- CodeStar connection to GitHub
- CodeBuild project
- CodePipeline for automated deployments

### API Gateway

- HTTP API with CORS configuration
- Production stage with logging
- Lambda integration and routes

## Usage

This module is designed to be used from the parent directory:

```hcl
module "event_pipeline" {
  source        = "./modules/sqs-lambda-pipeline"
  aws_region    = var.aws_region
  project_name  = var.project_name
  github_owner  = var.github_owner
  github_repo   = var.github_repo
  github_branch = var.github_branch
}
```

## Post-Deployment Steps

1. **Activate CodeStar Connection**: Go to AWS Console → Developer Tools →
   Settings → Connections and complete the GitHub authorization
2. **Set up Lambda Repository**: Create a GitHub repository with the Lambda
   functions using the structure expected by the buildspec.yml
3. **Test the Pipeline**: Push code to your Lambda repository to trigger the
   automated deployment

## Outputs

- API Gateway URL for testing
- SQS queue URL for monitoring
- Lambda function names for CloudWatch logs
- S3 bucket name for artifacts
- CodePipeline and CodeBuild names for monitoring deployments
- CodeStar connection ARN for reference
