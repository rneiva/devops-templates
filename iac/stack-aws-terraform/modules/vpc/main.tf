locals {
  region = var.aws_region
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.sg_name
  description = var.rds_description
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "${var.ingress_description}-sg"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = var.vpc_name
  cidr = element(var.vpc_cidr, 0)

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs                 = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  elasticache_subnets = var.elasticache_subnets

}

resource "aws_db_subnet_group" "main" {
  name       = var.subnet_group_name
  subnet_ids = module.vpc.public_subnets
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    security_groups  = [var.security_group_lb_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

