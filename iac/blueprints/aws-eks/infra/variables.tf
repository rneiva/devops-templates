variable "aws_region" {
  description = "value of AWS Region"
  type        = string
}

variable "aws_profile" {
  description = "value of AWS Profile"
  type        = string
}

variable "aws_account_id" {
  description = "value of AWS Account ID"
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

variable "cluster_version" {
  description = "value of EKS cluster version"
  type        = string
}

variable "managed_node_groups" {
  description = "value of EKS managed node groups"
  type        = any
}

variable "vpc_name" {
  description = "value of vpc name"
  type        = string
}

variable "vpc_cidr" {
  description = "value of vpc cidr"
  type        = list(string)
}

variable "public_subnets" {
  description = "value of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "value of private subnets"
  type        = list(string)
}

# variable "iam_developer_arn" {
#   description = "value of IAM developer arn"
#   type        = string
# }
