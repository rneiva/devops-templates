output "cognito_user_pull_id" {
  value = aws_cognito_user_pool.main.id
}

output "cognito_pool_client_id" {
  value = aws_cognito_user_pool_client.main.id
}

output "cognito_domain_id" {
  value = aws_cognito_user_pool_domain.main.id
}