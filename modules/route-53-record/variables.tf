################################################################################
# Route53 Record
################################################################################

variable "domain" {
  description = "(Required) Domain name for which the certificate should be issued."
  type        = string
  nullable    = false
}

variable "alb_dns_name" {
  description = "(Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone."
  type        = string
  nullable    = false
}

variable "alb_zone_id" {
  description = "(Required) Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone."
  type        = string
  nullable    = false
}
