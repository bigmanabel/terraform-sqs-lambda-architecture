# Random string for unique bucket naming
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 Bucket for Lambda artifacts and CodePipeline
resource "aws_s3_bucket" "lambda_artifacts" {
  bucket        = "${var.project_name}-lambda-artifacts-${random_string.bucket_suffix.result}"
  force_destroy = true  # Allow Terraform to delete bucket even if it contains objects
}

# S3 Bucket versioning
resource "aws_s3_bucket_versioning" "lambda_artifacts_versioning" {
  bucket = aws_s3_bucket.lambda_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_artifacts_encryption" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Create placeholder zip files for initial Lambda deployment
data "archive_file" "producer_placeholder" {
  type        = "zip"
  source_dir  = "${path.root}/placeholders/producer"
  output_path = "${path.root}/.terraform/producer_placeholder.zip"
}

data "archive_file" "consumer_placeholder" {
  type        = "zip"
  source_dir  = "${path.root}/placeholders/consumer"
  output_path = "${path.root}/.terraform/consumer_placeholder.zip"
}

# Upload placeholder zip files to S3 for initial Lambda deployment
# These will be replaced by CodePipeline when you deploy your actual code
resource "aws_s3_object" "producer_placeholder" {
  bucket = aws_s3_bucket.lambda_artifacts.bucket
  key    = "producer.zip"
  source = data.archive_file.producer_placeholder.output_path
  etag   = data.archive_file.producer_placeholder.output_md5

  # Lifecycle policy to ignore changes since CodePipeline will overwrite these
  lifecycle {
    ignore_changes = [
      etag,
    ]
  }
}

resource "aws_s3_object" "consumer_placeholder" {
  bucket = aws_s3_bucket.lambda_artifacts.bucket
  key    = "consumer.zip"
  source = data.archive_file.consumer_placeholder.output_path
  etag   = data.archive_file.consumer_placeholder.output_md5

  # Lifecycle policy to ignore changes since CodePipeline will overwrite these
  lifecycle {
    ignore_changes = [
      etag,
    ]
  }
}


