module "event_pipeline" {
  source        = "./modules/sqs-lambda-pipeline"
  aws_region    = var.aws_region
  project_name  = var.project_name
  github_owner  = var.github_owner
  github_repo   = var.github_repo
  github_branch = var.github_branch
}
