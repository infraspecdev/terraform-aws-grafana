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

variable "service_name" {
  description = "Name of the ECS Service."
  type        = string
  nullable    = false
}

variable "service_desired_count" {
  description = "Desired number of tasks to run in the ECS Service."
  type        = number
  nullable    = false
}

variable "service_subnet_ids" {
  description = "List of VPC subnet IDs where the infrastructure will be configured."
  type        = list(string)
  nullable    = false
}

variable "service_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

################################################################################
# ECS Task Definition
################################################################################

variable "task_definition_family" {
  description = "A unique name for your task definition."
  type        = string
  nullable    = false
}

variable "task_definition_grafana_image_version" {
  description = "Version tag to use with the Grafana docker image."
  type        = string
  nullable    = false
}

variable "task_definition_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

################################################################################
# Application Load Balancer
################################################################################

variable "alb_name" {
  description = "Name of the LB."
  type        = string
  nullable    = false
}

variable "alb_subnet_ids" {
  description = "List of public VPC subnet IDs where the Application Load Balancer will be configured."
  type        = list(string)
  nullable    = false
}

variable "alb_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

variable "alb_target_group_name" {
  description = "Name of the target group."
  type        = string
  nullable    = false
}

variable "alb_target_group_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

variable "alb_listener_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

################################################################################
# S3 Bucket
################################################################################

variable "s3_bucket_name" {
  description = "Name of the bucket where the Grafana ALB logs will be stored."
  type        = string
  nullable    = false
}

variable "s3_bucket_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
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

variable "acm_certificate_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

################################################################################
# IAM Role Sub-module
################################################################################

variable "grafana_task_role_name" {
  description = "Friendly name of the IAM role for Grafana tasks."
  type        = string
  nullable    = false
}

variable "grafana_task_role_description" {
  description = "Description of the IAM role for Grafana tasks."
  type        = string
  nullable    = false
}

variable "grafana_task_role_policies" {
  description = "Map of IAM policies to create and attach to the Grafana IAM Role."
  type = map(
    object({
      name        = string
      description = optional(string, null)
      policy = object({
        Version = optional(string, "2012-10-17")
        Statement = list(
          object({
            Sid      = optional(string)
            Effect   = string
            Resource = string
            Action   = optional(list(string), [])
          })
        )
      })
      tags = optional(map(string), {})
    })
  )
  nullable = false
}

variable "grafana_task_role_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

variable "grafana_execution_role_name" {
  description = "Friendly name of the IAM role for Grafana task execution."
  type        = string
  nullable    = false
}

variable "grafana_execution_role_description" {
  description = "Description of the IAM role for Grafana task execution."
  type        = string
  nullable    = false
}

variable "grafana_execution_role_policies" {
  description = "Map of IAM policies to create and attach to the Grafana Execution IAM Role."
  type = map(
    object({
      name        = string
      description = optional(string, null)
      policy = object({
        Version = optional(string, "2012-10-17")
        Statement = list(
          object({
            Sid      = optional(string)
            Effect   = string
            Resource = string
            Action   = optional(list(string), [])
          })
        )
      })
      tags = optional(map(string), {})
    })
  )
  nullable = false
}

variable "grafana_execution_role_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

################################################################################
# RDS Sub-module
################################################################################

variable "rds_identifier" {
  description = "The name of the Postgres RDS instance."
  type        = string
  nullable    = false
}

variable "rds_instance_class" {
  description = "The instance type of the Postgres RDS instance."
  type        = string
  nullable    = false
}

variable "rds_allocated_storage" {
  description = "The allocated storage in gibibytes."
  type        = number
  nullable    = false
}

variable "rds_postgres_engine_version" {
  description = "The Postgres engine version to use."
  type        = string
  nullable    = false
}

variable "rds_username" {
  description = "Username for the master DB user."
  type        = string
  nullable    = false
}

variable "rds_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

variable "rds_db_subnet_group_name" {
  description = "The name of the DB subnet group."
  type        = string
  nullable    = false
}

variable "rds_db_subnet_group_description" {
  description = "The description of the DB subnet group."
  type        = string
  nullable    = false
}

variable "rds_db_subnet_group_subnet_ids" {
  description = "A list of VPC subnet IDs."
  type        = list(string)
  nullable    = false
}

variable "rds_db_subnet_group_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}

variable "rds_db_parameter_group_name" {
  description = "The name of the DB parameter group."
  type        = string
  nullable    = false
}

variable "rds_db_parameter_group_description" {
  description = "The description of the DB parameter group."
  type        = string
  nullable    = false
}

variable "rds_db_parameter_group_family" {
  description = "The description of the DB parameter group."
  type        = string
  nullable    = false
}

variable "rds_db_parameter_group_parameters" {
  description = "The DB parameters to apply."
  type = list(
    object({
      name         = string
      value        = string
      apply_method = optional(string)
    })
  )
  nullable = false
}

variable "rds_db_parameter_group_tags" {
  description = "Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
}
