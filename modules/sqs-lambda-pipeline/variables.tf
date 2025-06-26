variable "project_name" {
  type        = string
  description = "Prefix for resource names"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "github_owner" {
  type        = string
  description = "GitHub repository owner/organization name"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name"
}

variable "github_branch" {
  type        = string
  description = "GitHub branch to track"
  default     = "main"
}
