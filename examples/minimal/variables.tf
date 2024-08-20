variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
  nullable    = false
}

variable "cluster_name" {
  description = "Name of the cluster."
  type        = string
  nullable    = false
}

################################################################################
# ECS Service
################################################################################

variable "service_subnet_ids" {
  description = "List of VPC subnet IDs where the infrastructure will be configured."
  type        = list(string)
  nullable    = false
}

################################################################################
# Application Load Balancer
################################################################################

variable "alb_subnet_ids" {
  description = "List of public VPC subnet IDs where the Application Load Balancer will be configured."
  type        = list(string)
  nullable    = false
}

################################################################################
# ACM
################################################################################

variable "acm_grafana_domain_name" {
  description = "Grafana domain name for which the certificate should be issued."
  type        = string
  nullable    = false
}

variable "acm_record_zone_id" {
  description = "Canonical hosted zone ID of the Load Balancer."
  type        = string
  nullable    = false
}

################################################################################
# RDS Sub-module
################################################################################

variable "rds_db_subnet_group_subnet_ids" {
  description = "A list of VPC subnet IDs."
  type        = list(string)
  nullable    = false
}
