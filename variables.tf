variable "vpc_id" {
  description = "(Required) The ID of the VPC."
  type        = string
  nullable    = false
}

variable "cluster_name" {
  description = "(Required) Name of the cluster."
  type        = string
  nullable    = false
}

################################################################################
# ECS Service
################################################################################

variable "service_name" {
  description = "(Optional, Default:grafana) Name of the ECS Service."
  type        = string
  nullable    = false
  default     = "grafana"
}

variable "service_desired_count" {
  description = "(Optional, Default:3) Desired number of tasks to run in the ECS Service."
  type        = number
  nullable    = false
  default     = 3
}

variable "service_subnet_ids" {
  description = "(Required) List of VPC subnet IDs where the infrastructure will be configured."
  type        = list(string)
  nullable    = false
}

variable "service_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# ECS Task Definition
################################################################################

variable "task_definition_family" {
  description = "(Optional, Default:\"grafana\") A unique name for your task definition."
  type        = string
  nullable    = false
  default     = "grafana"
}

variable "task_definition_grafana_image_version" {
  description = "(Optional, Default:11.1.2) Version tag to use with the Grafana docker image."
  type        = string
  nullable    = false
  default     = "11.1.2"
}

variable "task_definition_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# Application Load Balancer
################################################################################

variable "alb_name" {
  description = "(Optional, Default:\"grafana-alb\") Name of the LB."
  type        = string
  nullable    = false
  default     = "grafana-alb"
}

variable "alb_subnet_ids" {
  description = "(Required) List of public VPC subnet IDs where the Application Load Balancer will be configured."
  type        = list(string)
  nullable    = false
}

variable "alb_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

variable "alb_target_group_name" {
  description = "(Optional, Default:\"grafana-services\", Forces new resource) Name of the target group."
  type        = string
  nullable    = false
  default     = "grafana-services"
}

variable "alb_target_group_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

variable "alb_listener_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# S3 Bucket
################################################################################

variable "s3_bucket_name" {
  description = "(Optional, Default:\"grafana-services-alb-logs\", Forces new resource) Name of the bucket where the Grafana ALB logs will be stored."
  type        = string
  nullable    = false
  default     = "grafana-services-alb-logs"
}

variable "s3_bucket_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# ACM
################################################################################

variable "acm_grafana_domain_name" {
  description = "(Required) Grafana domain name for which the certificate should be issued."
  type        = string
  nullable    = false
}

variable "acm_record_zone_id" {
  description = "(Required) Canonical hosted zone ID of the Load Balancer."
  type        = string
  nullable    = false
}

variable "acm_certificate_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# IAM Role Sub-module
################################################################################

variable "grafana_task_role_name" {
  description = "(Optional, Default:\"grafana-task-iam-role\", Forces new resource) Friendly name of the IAM role for Grafana tasks."
  type        = string
  nullable    = false
  default     = "grafana-task-iam-role"
}

variable "grafana_task_role_description" {
  description = "(Optional, Default:\"Managed By Terraform\") Description of the IAM role for Grafana tasks."
  type        = string
  nullable    = false
  default     = "Managed By Terraform"
}

variable "grafana_task_role_policies" {
  description = "(Optional, Default:rds,athena) Map of IAM policies to create and attach to the Grafana IAM Role."
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
  default = {
    rds = {
      name        = "grafana-task-iam-role-rds"
      description = "Allow access to RDS"

      policy = {
        Statement = [
          {
            Sid      = "AllowRDSFullAccess"
            Effect   = "Allow"
            Resource = "*"
            Action = [
              "rds:*"
            ]
          }
        ]
      }
    }
    athena = {
      name        = "grafana-task-iam-role-athena"
      description = "Allow access to Athena"

      policy = {
        Statement = [
          {
            "Sid" : "AllowAthenaFullAccess",
            "Effect" : "Allow",
            "Resource" : "*",
            "Action" : [
              "athena:*"
            ],
          },
          {
            "Sid" : "AllowGlueFullAccess",
            "Effect" : "Allow",
            "Action" : [
              "glue:CreateDatabase",
              "glue:DeleteDatabase",
              "glue:GetDatabase",
              "glue:GetDatabases",
              "glue:UpdateDatabase",
              "glue:CreateTable",
              "glue:DeleteTable",
              "glue:BatchDeleteTable",
              "glue:UpdateTable",
              "glue:GetTable",
              "glue:GetTables",
              "glue:BatchCreatePartition",
              "glue:CreatePartition",
              "glue:DeletePartition",
              "glue:BatchDeletePartition",
              "glue:UpdatePartition",
              "glue:GetPartition",
              "glue:GetPartitions",
              "glue:BatchGetPartition",
              "glue:StartColumnStatisticsTaskRun",
              "glue:GetColumnStatisticsTaskRun",
              "glue:GetColumnStatisticsTaskRuns",
              "glue:GetCatalogImportStatus"
            ],
            "Resource" : "*"
          },
        ]
      }
    }
  }
}

variable "grafana_task_role_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

variable "grafana_execution_role_name" {
  description = "(Optional, Default:\"grafana-task-execution-iam-role\", Forces new resource) Friendly name of the IAM role for Grafana task execution."
  type        = string
  nullable    = false
  default     = "grafana-task-execution-iam-role"
}

variable "grafana_execution_role_description" {
  description = "(Optional, Default:\"Managed By Terraform\") Description of the IAM role for Grafana task execution."
  type        = string
  nullable    = false
  default     = "Managed By Terraform"
}

variable "grafana_execution_role_policies" {
  description = "(Optional, Default:secrets-manager) Map of IAM policies to create and attach to the Grafana Execution IAM Role."
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
  default = {
    secrets-manager = {
      name        = "grafana-execution-role-secrets-manager"
      description = "Allow access to Secrets Manager"

      policy = {
        Statement = [
          {
            Sid      = "AllowSecretsManagerFullAccess"
            Effect   = "Allow"
            Resource = "*"
            Action = [
              "secretsmanager:*"
            ]
          }
        ]
      }
    }
  }
}

variable "grafana_execution_role_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# RDS Sub-module
################################################################################

variable "rds_identifier" {
  description = "(Optional, Default:\"grafana-backend\") The name of the Postgres RDS instance."
  type        = string
  nullable    = false
  default     = "grafana-backend"
}

variable "rds_instance_class" {
  description = "(Optional, Default:\"db.t3.micro\") The instance type of the Postgres RDS instance."
  type        = string
  nullable    = false
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "(Optional, Default:10) The allocated storage in gibibytes."
  type        = number
  nullable    = false
  default     = 10
}

variable "rds_postgres_engine_version" {
  description = "(Optional, Default:\"16.3\") The Postgres engine version to use."
  type        = string
  nullable    = false
  default     = "16.3"
}

variable "rds_username" {
  description = "(Optional, Default:\"grafana_admin\") Username for the master DB user."
  type        = string
  nullable    = false
  default     = "grafana_admin"
}

variable "rds_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

variable "rds_db_subnet_group_name" {
  description = "(Optional, Default:\"grafana-rds-subnet-group\", Forces new resource) The name of the DB subnet group."
  type        = string
  nullable    = false
  default     = "grafana-rds-subnet-group"
}

variable "rds_db_subnet_group_description" {
  description = "(Optional, Default:\"Managed By Terraform\", Forces new resource) The description of the DB subnet group."
  type        = string
  nullable    = false
  default     = "Managed By Terraform"
}

variable "rds_db_subnet_group_subnet_ids" {
  description = "(Required) A list of VPC subnet IDs."
  type        = list(string)
  nullable    = false
}

variable "rds_db_subnet_group_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

variable "rds_db_parameter_group_name" {
  description = "(Optional, Default:\"grafana-rds-parameter-group\", Forces new resource) The name of the DB parameter group."
  type        = string
  nullable    = false
  default     = "grafana-rds-parameter-group"
}

variable "rds_db_parameter_group_description" {
  description = "(Optional, Default:\"Managed By Terraform\", Forces new resource) The description of the DB parameter group."
  type        = string
  nullable    = false
  default     = "Managed By Terraform"
}

variable "rds_db_parameter_group_family" {
  description = "(Optional, Default:\"postgres16\", Forces new resource) The description of the DB parameter group."
  type        = string
  nullable    = false
  default     = "postgres16"
}

variable "rds_db_parameter_group_parameters" {
  description = "(Optional, Default:[]) The DB parameters to apply."
  type = list(
    object({
      name         = string
      value        = string
      apply_method = optional(string)
    })
  )
  nullable = false
  default = [
    {
      name         = "rds.force_ssl"
      value        = "0"
      apply_method = "immediate"
    }
  ]
}

variable "rds_db_parameter_group_tags" {
  description = "(Optional, Default:{}) Map of Resources Tags to attach to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}
