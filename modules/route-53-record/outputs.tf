################################################################################
# Route53 Record
################################################################################

output "id" {
  description = "Identifier of the Route53 Record"
  value       = aws_route53_record.this.id
}
