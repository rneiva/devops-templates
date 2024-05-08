variable "private_subnets" {
  description = "value of private_subnets from vpc module"
  type        = list(string)
}

variable "vpc_id" {
  description = "value of vpc_id from vpc module"
  type        = string
}

variable "cluster_primary_sg" {
  description = "value of cluster_primary_security_group_id from eks_blueprints module"
  type        = string
}
