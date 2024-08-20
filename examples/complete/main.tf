module "grafana" {
  source = "../../"

  vpc_id       = var.vpc_id
  cluster_name = var.cluster_name

  # ECS Service
  service_name          = var.service_name
  service_subnet_ids    = var.service_subnet_ids
  service_desired_count = var.service_desired_count
  service_tags          = var.service_tags

  # ECS Task Definition
  task_definition_family                = var.task_definition_family
  task_definition_grafana_image_version = var.task_definition_grafana_image_version
  task_definition_tags                  = var.task_definition_tags

  # ALB
  alb_name       = var.alb_name
  alb_subnet_ids = var.alb_subnet_ids
  alb_tags       = var.alb_tags
  # # Target Group
  alb_target_group_name = var.alb_target_group_name
  alb_target_group_tags = var.alb_target_group_tags
  # # Listener
  alb_listener_tags = var.alb_listener_tags

  # S3 Bucket
  s3_bucket_name = var.s3_bucket_name
  s3_bucket_tags = var.s3_bucket_tags

  # ACM
  acm_grafana_domain_name = var.acm_grafana_domain_name
  acm_record_zone_id      = var.acm_record_zone_id
  acm_certificate_tags    = var.acm_certificate_tags

  # Task IAM Role
  grafana_task_role_name        = var.grafana_task_role_name
  grafana_task_role_description = var.grafana_task_role_description
  grafana_task_role_policies    = var.grafana_task_role_policies
  grafana_task_role_tags        = var.grafana_task_role_tags

  # Task Execution IAM Role
  grafana_execution_role_name        = var.grafana_execution_role_name
  grafana_execution_role_description = var.grafana_execution_role_description
  grafana_execution_role_policies    = var.grafana_execution_role_policies
  grafana_execution_role_tags        = var.grafana_execution_role_tags

  # RDS
  rds_identifier              = var.rds_identifier
  rds_instance_class          = var.rds_instance_class
  rds_allocated_storage       = var.rds_allocated_storage
  rds_postgres_engine_version = var.rds_postgres_engine_version
  rds_username                = var.rds_username
  rds_tags                    = var.rds_tags
  # # DB Subnet Group
  rds_db_subnet_group_name        = var.rds_db_subnet_group_name
  rds_db_subnet_group_description = var.rds_db_subnet_group_description
  rds_db_subnet_group_subnet_ids  = var.rds_db_subnet_group_subnet_ids
  rds_db_subnet_group_tags        = var.rds_db_subnet_group_tags
  # # DB Parameter Group
  rds_db_parameter_group_name        = var.rds_db_parameter_group_name
  rds_db_parameter_group_description = var.rds_db_parameter_group_description
  rds_db_parameter_group_family      = var.rds_db_parameter_group_family
  rds_db_parameter_group_parameters  = var.rds_db_parameter_group_parameters
  rds_db_parameter_group_tags        = var.rds_db_parameter_group_tags
}
