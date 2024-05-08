variable "sns_name" {
  type = string
}

variable "account_id" {
  type = string
}

variable "tags_sns" {
  type = any
  default = {
    "Name"        = "SNS"
    "Projeto"     = "Amigoz"
    "Service"     = "SNS"
    "Environment" = "Production"
    "Provider"    = "Terraform"
  }
}