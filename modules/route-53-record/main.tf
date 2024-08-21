locals {
  domain_parts = regexall("(.*\\.)?(.*\\..*)", var.domain)
  base_domain = (
    length(local.domain_parts) > 0 && length(local.domain_parts[0]) > 1 ?
  local.domain_parts[0][1] : var.domain)
}

################################################################################
# ACM Certificate
################################################################################

data "aws_route53_zone" "base_domain" {
  name = local.base_domain
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.base_domain.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
