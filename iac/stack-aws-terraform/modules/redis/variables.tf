variable "sg_redis" {
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

variable "elasticache_engine_version" {
  type = string
}

variable "elisticache_nodes" {
  type = string
}
variable "vpc_cidr" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "elasticache_subnets" {
  type = list(string)
}

variable "elastic_sbnt" {
  type = string
}

variable "elasticache_subnets_ids" {
  type = list(string)
}