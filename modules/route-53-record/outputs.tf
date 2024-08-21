################################################################################
# Route53 Record
################################################################################

output "id" {
  description = "Identifier of the Route53 Record"
  value       = aws_route53_record.this.id
}

output "zone_id" {
  description = "ID of the Route 53 zone"
  value       = data.aws_route53_zone.base_domain.zone_id
}
