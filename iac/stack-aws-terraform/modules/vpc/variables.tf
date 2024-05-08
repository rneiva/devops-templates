variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = list(string)
}

variable "rds_description" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "ingress_description" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "subnet_group_name" {
  description = "A list of VPC subnet of RDS"
}

variable "aws_region" {
  type = string
}

variable "elasticache_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "security_group_lb_id" {
  type = string
}
