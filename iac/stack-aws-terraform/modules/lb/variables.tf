variable "lb_name" {
  type = string
}

variable "target_group" {
  type = string
}

variable "tags_lb" {
  type = any
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "bucket_lb_logs" {
  type = string
}

variable "public_subnets_ids" {
  type = list(string)
}

variable "certificate_arn" {
  type = string
}