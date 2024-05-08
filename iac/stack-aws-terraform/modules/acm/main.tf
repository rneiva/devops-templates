data "aws_route53_zone" "route_zone" {
  name = var.zones
}

resource "aws_acm_certificate" "amigozcertificate" {
  domain_name       = var.domain_certificate
  validation_method = "DNS"

  tags = {
    Environment = "Production"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "record_certificate" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.amigozcertificate.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.amigozcertificate.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.amigozcertificate.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.route_zone.zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.amigozcertificate.arn
  validation_record_fqdns = [aws_route53_record.record_certificate.fqdn]
}