module "iam" {
  source                  = "../modules/iam"
  iam_user                = var.iam_user
  iam_sns_policy          = var.iam_sns_policy
  iam_ecr_policy          = var.iam_ecr_policy
  ecs_task_execution_role = var.ecs_task_execution_role
}

module "s3" {
  source      = "../modules/s3"
  bucket_code = var.bucket_code
  bucket_acl  = var.bucket_acl
  bucket_logs = var.bucket_logs
  iam_arn     = module.iam.iam_arn
  tags_s3     = var.tags_s3

  depends_on = [module.iam]
}

module "vpc" {
  source               = "../modules/vpc"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  rds_description      = var.rds_description
  sg_name              = var.sg_name
  ingress_description  = "${var.ingress_description}-vpc"
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  subnet_group_name    = var.subnet_group_name
  aws_region           = var.aws_region
  elasticache_subnets  = var.elasticache_subnets
  vpc_id               = module.vpc.vpc_id
  security_group_lb_id = module.lb.security_group_lb_id
}

module "ses" {
  source = "../modules/ses"

  environment = var.environment
  domain      = var.domain
}

module "sns" {
  source     = "../modules/sns"
  sns_name   = var.sns_name
  account_id = var.account_id
  tags_sns   = var.tags_sns
}

module "cognito" {
  source            = "../modules/cognito"
  cognito_user_pool = var.cognito_user_pool
  cognito_domain    = var.cognito_domain
  cognito_client    = var.cognito_client
  tags_cognito      = var.tags_cognito
}

module "rds" {
  source              = "../modules/rds"
  aws_region          = var.aws_region
  postgres            = var.postgres
  postgres_dbname     = var.postgres_dbname
  postgres_username   = var.postgres_username
  postgres_password   = var.postgres_password
  postgres_port       = var.postgres_port
  ingress_description = "${var.ingress_description}-rds"
  subnet_group_name   = var.subnet_group_name
  security_group_id   = module.vpc.security_group_id
  rds_record          = var.rds_record
  tags_db             = var.tags_db
  zones               = var.zones
}

module "redis" {
  source                     = "../modules/redis"
  sg_redis                   = var.sg_redis
  elasticache_cluster        = var.elasticache_cluster
  elasticache_engine         = var.elasticache_engine
  elasticache_node_type      = var.elasticache_node_type
  elasticache_group          = var.elasticache_group
  elasticache_engine_version = var.elasticache_engine_version
  elisticache_nodes          = var.elisticache_nodes
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr                   = var.vpc_cidr
  elasticache_subnets        = var.elasticache_subnets
  elastic_sbnt               = var.elastic_sbnt
  elasticache_subnets_ids    = module.vpc.elasticache_subnets_ids
}

module "lb" {
  source             = "../modules/lb"
  target_group       = var.target_group
  lb_name            = var.lb_name
  tags_lb            = var.tags_lb
  vpc_id             = module.vpc.vpc_id
  public_subnets     = var.public_subnets
  bucket_lb_logs     = module.s3.bucket_lb_logs
  public_subnets_ids = module.vpc.public_subnets_ids
  certificate_arn     = var.certificate_arn
}

module "ecs" {
  source                  = "../modules/ecs"
  cluster_name            = var.cluster_name
  task_name               = var.task_name
  tags_ecs                = var.tags_ecs
  ecs_task_execution_role = module.iam.ecs_task_execution_role
  cloudwatch_log_group    = var.cloudwatch_log_group
  ecr_image               = var.ecr_image
  account_id              = var.account_id
  aws_region              = var.aws_region
  target_group_arn        = module.lb.target_group_arn
  lb_sg_id                = module.lb.lb_sg_id
  ecs_svc_sg_id           = module.vpc.ecs_svc_sg_id
  public_subnets          = var.public_subnets
  ecs_service_name        = var.ecs_service_name
  public_subnets_ids      = module.vpc.public_subnets_ids

  depends_on = [module.lb]
}
