module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.postgres["identifier"]

  engine               = var.postgres["engine"]
  engine_version       = var.postgres["engine_version"]
  family               = var.postgres["family"]
  major_engine_version = var.postgres["major_engine_version"]
  instance_class       = var.postgres["instance_class"]

  allocated_storage = 20

  db_name  = var.postgres_dbname
  username = var.postgres_username
  password = var.postgres_password
  port     = var.postgres_port

  multi_az               = false
  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = [var.security_group_id]

  maintenance_window              = var.postgres["maintenance_window"]
  backup_window                   = var.postgres["backup_window"]
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = false

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
  publicly_accessible     = true

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }

  tags = var.tags_db

}

data "aws_route53_zone" "main" {
  name = var.zones
}

resource "aws_route53_record" "rds_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.rds_record
  type    = "CNAME"
  ttl     = "300"

  records = ["${module.db.db_instance_address}"]

  depends_on = [
    module.db
  ]

}