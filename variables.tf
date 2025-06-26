variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Name prefix for all resources"
  default     = "event-pipeline"
}

variable "github_owner" {
  type        = string
  description = "GitHub repository owner/organization name (required)"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name (required)"
}

variable "github_branch" {
  type        = string
  description = "GitHub branch to track"
  default     = "main"
}
