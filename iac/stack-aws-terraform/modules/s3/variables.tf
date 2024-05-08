variable "bucket_code" {
  type = string
}

variable "bucket_acl" {
  type = string
}

variable "tags_s3" {
  type = any
  default = {
    "Name"        = "S3"
    "Projeto"     = "Amigoz"
    "Service"     = "S3 Bucket"
    "Environment" = "Production"
    "Provider"    = "Terraform"
  }
}

variable "iam_arn" {
  type = string
}

variable "bucket_logs" {
  type = string
}
