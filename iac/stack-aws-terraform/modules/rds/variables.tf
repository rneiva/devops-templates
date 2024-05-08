variable "aws_region" {
  type = string
}

variable "postgres" {
  type = any
}

variable "tags_db" {
  type = any
  default = {
    "Name"        = "DB"
    "Projeto"     = "Amigoz"
    "Service"     = "DB"
    "Environment" = "Staging"
    "Provider"    = "Terraform"
  }
}

variable "postgres_dbname" {
  type = string
}

variable "postgres_password" {
  type = string
}

variable "postgres_port" {
  type = number
}

variable "postgres_username" {
  type = string
}

variable "ingress_description" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "rds_record" {
  type = string
}

variable "zones" {
  type = string
}