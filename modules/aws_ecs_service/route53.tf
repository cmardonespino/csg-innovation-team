locals {
  route53_zone_domain = "dev.csg-innovation.com"
  application_domain  = "app.${local.route53_zone_domain}"
}

data "aws_route53_zone" "application_domain" {
  name = "${local.route53_zone_domain}."
}

resource "aws_route53_record" "application_domain" {
  zone_id         = data.aws_route53_zone.application_domain.zone_id
  name            = local.application_domain
  type            = "A"
  allow_overwrite = true

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

output "domain" {
  description = "ECS service domain name"
  value       = aws_route53_record.application_domain.name
}

