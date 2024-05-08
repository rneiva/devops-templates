variable "tags_ecs" {
  type = any
  default = {
    "Name"        = "ECS"
    "Projeto"     = "Project"
    "Service"     = "ECS"
    "Environment" = "Production"
    "Provider"    = "Terraform"
  }
}

variable "cluster_name" {
  type = string
}

variable "ecs_task_execution_role" {
  type = string
}

variable "task_name" {
  type = string
}

variable "account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "ecs_svc_sg_id" {
  type = string
}

variable "lb_sg_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "ecs_service_name" {
  type = string
}

variable "public_subnets_ids" {
  type = list(string)
}

variable "ecr_image" {
  type = string
}

variable "cloudwatch_log_group" {
  type = string
}