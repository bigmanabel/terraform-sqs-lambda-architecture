# CodeBuild Project
resource "aws_codebuild_project" "lambda_build" {
  name         = "${var.project_name}-lambda-build"
  description  = "Build project for Lambda functions"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "S3_BUCKET"
      value = aws_s3_bucket.lambda_artifacts.bucket
    }

    environment_variable {
      name  = "PRODUCER_FUNCTION_NAME"
      value = aws_lambda_function.producer.function_name
    }

    environment_variable {
      name  = "CONSUMER_FUNCTION_NAME"
      value = aws_lambda_function.consumer.function_name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}
