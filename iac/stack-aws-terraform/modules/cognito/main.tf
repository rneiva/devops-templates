resource "aws_cognito_user_pool" "main" {
  name = var.cognito_user_pool

  password_policy {
    minimum_length                   = "6"
    require_lowercase                = "false"
    require_numbers                  = "true"
    require_symbols                  = "false"
    require_uppercase                = "false"
    temporary_password_validity_days = 7
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "id"
    required                 = false
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  tags = var.tags_cognito
}

resource "aws_cognito_user_pool_client" "main" {
  name = var.cognito_client

  user_pool_id                  = aws_cognito_user_pool.main.id
  generate_secret               = false
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]

}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.cognito_domain
  user_pool_id = aws_cognito_user_pool.main.id

}