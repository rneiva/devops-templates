output "security_group_id" {
  value = module.security_group.security_group_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecs_svc_sg_id" {
  value = aws_security_group.main.id
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets
}

output "elasticache_subnets_ids" {
  value = module.vpc.elasticache_subnets
}
