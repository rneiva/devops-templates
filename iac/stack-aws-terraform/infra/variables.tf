variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "bucket_code" {
  type = string
}

variable "bucket_logs" {
  type = string
}

variable "sg_redis" {
  type = string
}

variable "iam_ecr_policy" {
  type = string
}

variable "iam_user" {
  type = string
}

variable "bucket_acl" {
  type = string
}

variable "ecs_service_name" {
  type = string
}
variable "sns_name" {
  type = string
}

variable "domain" {
  type = string
}

variable "zones" {
  type = string
}

variable "record_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "account_id" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "iam_sns_policy" {
  type = string
}

variable "cognito_domain" {
  type = string
}

variable "cognito_client" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "rds_record" {
  type = string
}

variable "cognito_user_pool" {
  type = string
}

variable "elasticache_cluster" {
  type = string
}

variable "elasticache_engine" {
  type = string
}

variable "elasticache_node_type" {
  type = string
}

variable "elasticache_group" {
  type = string
}

variable "ecr_image" {
  type = string
}

variable "elasticache_engine_version" {
  type = string
}

variable "ingress_description" {
  type = string
}

variable "rds_description" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "postgres_dbname" {
  type = string
}

variable "postgres_password" {
  type = string
}

variable "postgres_username" {
  type = string
}

variable "vpc_cidr" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "lb_name" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "elasticache_subnets" {
  description = "A list of VPC subnet IDs for Elasticache"
  type        = list(string)
}

variable "elastic_sbnt" {
  type = string

}

variable "subnet" {
  type = any
  default = {
    name        = ""
    prefix      = ""
    description = ""
  }

}

variable "postgres" {
  type = any
}

variable "target_group" {
  type = string
}

variable "cloudwatch_log_group" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "postgres_port" {
  type = number
}

variable "elisticache_nodes" {
  type = number
}

variable "ecs_task_execution_role" {
  type = string
}

variable "task_name" {
  type = string
}

variable "tags_certificate" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}

variable "tags_s3" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}

variable "tags_ecs" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}

variable "tags_lb" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}

variable "tags_db" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}

variable "tags_cognito" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}

variable "tags_route53" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}

variable "tags_sns" {
  type = any
  default = {
    "Name"        = ""
    "Projeto"     = ""
    "Service"     = ""
    "Environment" = ""
    "Provider"    = ""
  }
}
