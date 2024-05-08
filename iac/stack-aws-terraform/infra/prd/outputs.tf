#IAM
output "iam_user" {
  value = module.iam.iam_user

}

output "iam_secret_key" {
  value     = module.iam.iam_secret_key
  sensitive = true
}

#RDS
output "rds_address" {
  value = module.rds.rds_address

}

output "rds_route53_record" {
  value = module.rds.rds_route53_record
}


output "bucket_region" {
  value = module.s3.bucket_region

}

#SNS

output "sns_endpoint" {
  value = module.sns.sns_endpoint

}

#ECS
output "ecs_cluster" {
  value = module.ecs.ecs_cluster
}

output "ecs_id" {
  value = module.ecs.ecs_id
}

#Cognito

output "cognito_user_pull_id" {
  value = module.cognito.cognito_user_pull_id
}

output "cognito_pool_client_id" {
  value = module.cognito.cognito_pool_client_id
}

output "cognito_domain_id" {
  value = module.cognito.cognito_domain_id
}