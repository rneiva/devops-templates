locals {
  region      = var.aws_region
  name        = var.cluster_name
  environment = var.environment
  tags = {
    environment = local.environment
    terraform   = "true"
    created-by  = local.name
  }
}
