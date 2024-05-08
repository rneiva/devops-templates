output "rds_address" {
  value = module.db.db_instance_address

}

output "rds_route53_record" {
  value = aws_route53_record.rds_record.fqdn
}
