//Create Zone Domain
resource "aws_route53_zone" "zone_domain" {
  name = var.zone_domain
}

//Create www record to URL
resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "wp.mecontrata.cloud"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

//Create certificate in ACM
resource "aws_acm_certificate" "certificate" {
  domain_name       = "wp.mecontrata.cloud"
  validation_method = "DNS"

  tags = {
    Environment = "certificate-ecs"
  }

  lifecycle {
    create_before_destroy = true
  }
}

//Record certificate create with URL in Route53
resource "aws_route53_record" "dns_certificate" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_type
  zone_id         = var.zone_id
  ttl             = 60
}

//Validation certificate in ACM
resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.dns_certificate.fqdn]
}
