module "vpc" {
  source = "../modules/vpc"

  environment     = var.environment
  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  aws_region      = var.aws_region
}

module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.32.1"

  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  enable_irsa         = true
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  managed_node_groups = var.managed_node_groups

  tags = local.tags
}

module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.32.1"

  eks_cluster_id = module.eks_blueprints.eks_cluster_id

  # EKS Add-ons
  enable_aws_efs_csi_driver    = true

  # Self-managed Add-ons
  enable_aws_load_balancer_controller = true
  enable_metrics_server               = true
  enable_cert_manager                 = true
  enable_argocd                       = true
  enable_aws_for_fluentbit            = true
  # enable_cluster_autoscaler           = true
  enable_karpenter                    = true
}
