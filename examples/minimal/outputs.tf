################################################################################
# Grafana ECS Deployment
################################################################################

################################################################################
# # ECS Service
################################################################################

output "grafana_ecs_service_arn" {
  description = "ARN that identifies the Grafana ECS service."
  value       = module.grafana.grafana_ecs_service_arn
}

################################################################################
# # ECS Task Definition
################################################################################

output "grafana_ecs_task_definition_arn" {
  description = "Full ARN of the Grafana ECS Task Definition."
  value       = module.grafana.grafana_ecs_task_definition_arn
}

################################################################################
# # Amazon Certificates Manager
################################################################################

output "acm_certificate_id" {
  description = "Identifier of the ACM certificate for Grafana endpoint."
  value       = module.grafana.acm_certificate_id
}

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate for Grafana endpoint."
  value       = module.grafana.acm_certificate_arn
}

output "acm_route53_record_id" {
  description = "Identifier of the Route53 Record for validation of the Grafana endpoint ACM certificate."
  value       = module.grafana.acm_route53_record_id
}

output "acm_certificate_validation_id" {
  description = "Identifier of the Grafana endpoint ACM certificate validation resource."
  value       = module.grafana.acm_certificate_validation_id
}

################################################################################
# # Application Load Balancer
################################################################################

output "alb_arn" {
  description = "ARN of the Grafana load balancer."
  value       = module.grafana.alb_arn
}

output "alb_dns_name" {
  description = "DNS name of the Grafana load balancer."
  value       = module.grafana.alb_dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID of the Grafana Load Balancer."
  value       = module.grafana.alb_zone_id
}

output "alb_target_group_id" {
  description = "Identifier of the Target Group of Grafana services."
  value       = module.grafana.alb_target_group_id
}

output "alb_target_group_arn" {
  description = "ARN of the Target Group of Grafana services."
  value       = module.grafana.alb_target_group_arn
}

output "alb_listener_id" {
  description = "Identifier of the Listener for Grafana services."
  value       = module.grafana.alb_listener_id
}

output "alb_listener_arn" {
  description = "ARN of the Listener for Grafana services."
  value       = module.grafana.alb_listener_arn
}

################################################################################
# # S3 Bucket
################################################################################

output "s3_bucket_id" {
  description = "Name of the bucket where the Grafana ALB logs will be stored."
  value       = module.grafana.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "ARN of the bucket where the Grafana ALB logs will be stored."
  value       = module.grafana.s3_bucket_arn
}

################################################################################
# IAM Role Sub-module
################################################################################

output "grafana_task_iam_role_id" {
  description = "Name of the Grafana Task IAM role."
  value       = module.grafana.grafana_task_iam_role_id
}

output "grafana_task_iam_role_arn" {
  description = "Amazon Resource Name (ARN) specifying the Grafana Task IAM role."
  value       = module.grafana.grafana_task_iam_role_arn
}

output "grafana_task_iam_role_policies_ids" {
  description = "Map of IAM Policies Identifiers created and attached with the Grafana Task IAM role."
  value       = module.grafana.grafana_task_iam_role_policies_ids
}

output "grafana_task_iam_role_policies_arns" {
  description = "Map of IAM Policies ARNs created and attached with the Grafana Task IAM role."
  value       = module.grafana.grafana_task_iam_role_policies_arns
}

output "grafana_execution_iam_role_id" {
  description = "Name of the Grafana Execution IAM role."
  value       = module.grafana.grafana_execution_iam_role_id
}

output "grafana_execution_iam_role_arn" {
  description = "Amazon Resource Name (ARN) specifying the Grafana Execution IAM role."
  value       = module.grafana.grafana_execution_iam_role_arn
}

output "grafana_execution_iam_role_policies_ids" {
  description = "Map of IAM Policies Identifiers created and attached with the Grafana Execution IAM role."
  value       = module.grafana.grafana_execution_iam_role_policies_ids
}

output "grafana_execution_iam_role_policies_arns" {
  description = "Map of IAM Policies ARNs created and attached with the Grafana Execution IAM role."
  value       = module.grafana.grafana_execution_iam_role_policies_arns
}

################################################################################
# RDS Sub-module
################################################################################

output "rds_id" {
  description = "Grafana RDS DBI resource ID."
  value       = module.grafana.rds_id
}

output "rds_arn" {
  description = "The ARN of the Grafana RDS instance."
  value       = module.grafana.rds_arn
}

output "rds_endpoint" {
  description = "The Grafana RDS connection endpoint in `address:port` format."
  value       = module.grafana.rds_endpoint
}

output "rds_master_user_secret" {
  description = "Details of the secret containing the database master password for Grafana RDS."
  value       = module.grafana.rds_master_user_secret
}

output "rds_db_subnet_group_id" {
  description = "The db subnet group name to use with the Grafana RDS."
  value       = module.grafana.rds_db_subnet_group_id
}

output "rds_db_subnet_group_arn" {
  description = "The ARN of the db subnet group attached with Grafana RDS."
  value       = module.grafana.rds_db_subnet_group_arn
}

output "rds_db_parameter_group_id" {
  description = "The db parameter group name to use with the Grafana RDS."
  value       = module.grafana.rds_db_parameter_group_id
}

output "rds_db_parameter_group_arn" {
  description = "The ARN of the db parameter group attached with Grafana RDS."
  value       = module.grafana.rds_db_parameter_group_arn
}

################################################################################
# Security Groups
################################################################################

output "ecs_service_security_group_id" {
  description = "Identifier of the Grafana ECS Service Security Group."
  value       = module.grafana.ecs_service_security_group_id
}

output "ecs_service_security_group_arn" {
  description = "ARN of the Grafana ECS Service Security Group."
  value       = module.grafana.ecs_service_security_group_arn
}

output "grafana_alb_security_group_id" {
  description = "Identifier of the Grafana ALB Security Group."
  value       = module.grafana.grafana_alb_security_group_id
}

output "grafana_alb_security_group_arn" {
  description = "ARN of the Grafana ALB Security Group."
  value       = module.grafana.grafana_alb_security_group_arn
}

output "grafana_backend_rds_security_group_id" {
  description = "Identifier of the Grafana Backend RDS Security Group."
  value       = module.grafana.grafana_backend_rds_security_group_id
}

output "grafana_backend_rds_security_group_arn" {
  description = "ARN of the Grafana Backend RDS Security Group."
  value       = module.grafana.grafana_backend_rds_security_group_arn
}
