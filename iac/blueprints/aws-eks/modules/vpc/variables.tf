variable "aws_region" {
  description = "value of AWS region"
  type        = string
}

variable "environment" {
  description = "value of environment"
  type        = string
}

variable "cluster_name" {
  description = "value of EKS cluster version"
  type        = string
}

variable "vpc_name" {
  description = "value of VPC name"
  type        = string
}

variable "vpc_id" {
  description = "value of VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "value of VPC CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "value of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "value"
  type        = list(string)
}
