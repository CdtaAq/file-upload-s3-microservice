resource "aws_route53_record" "insurance_dns" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.insurance_alb.dns_name
    zone_id                = aws_lb.insurance_alb.zone_id
    evaluate_target_health = true
  }
}
