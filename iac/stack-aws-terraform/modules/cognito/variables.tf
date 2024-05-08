variable "tags_cognito" {
  type = any
  default = {
    "Name"        = "Cognito User"
    "Projeto"     = "Amigoz"
    "Service"     = "Cognito"
    "Environment" = "Production"
    "Provider"    = "Terraform"
  }
}

variable "cognito_user_pool" {

}

variable "cognito_domain" {

}

variable "cognito_client" {

}
