provider "aws" {
  region = "ap-south-1"
}

################################################################################
# Route53 Record
################################################################################

run "route53_record_attributes_match" {
  command = plan

  module {
    source = "./modules/route-53-record"
  }

  variables {
    zone_id      = "ExampleZoneId"
    domain       = "example.com"
    alb_dns_name = "example-alb-123456789.ap-south-1.elb.amazonaws.com"
    alb_zone_id  = "Z123456789EXAMPLE"
  }

  assert {
    condition     = aws_route53_record.this.name == var.domain
    error_message = "Domain name mismatch"
  }

  assert {
    condition     = aws_route53_record.this.type == "A"
    error_message = "Record type mismatch"
  }

  assert {
    condition     = aws_route53_record.this.alias[0].name == var.alb_dns_name
    error_message = "ALB DNS name mismatch"
  }

  assert {
    condition     = aws_route53_record.this.alias[0].zone_id == var.alb_zone_id
    error_message = "ALB zone ID mismatch"
  }

  assert {
    condition     = aws_route53_record.this.alias[0].evaluate_target_health == true
    error_message = "Evaluate target health mismatch"
  }
}
