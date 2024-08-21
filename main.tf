locals {
  grafana_port = 3000

  # ECS Task Definition
  task_cpu                 = 512
  task_memory              = 512
  grafana_container_name   = "grafana"
  grafana_container_image  = "grafana/grafana:${var.task_definition_grafana_image_version}"
  grafana_container_cpu    = 512
  grafana_container_memory = 512
  grafana_container_environment = {
    "GF_DATABASE_TYPE"   = "postgres"
    "GF_DATABASE_HOST"   = module.grafana_backend_rds.endpoint
    "GF_INSTALL_PLUGINS" = "grafana-athena-datasource"
  }
  grafana_container_secrets = {
    "GF_DATABASE_USER"     = "${module.grafana_backend_rds.master_user_secret.secret_arn}:username::"
    "GF_DATABASE_PASSWORD" = "${module.grafana_backend_rds.master_user_secret.secret_arn}:password::"
  }

  # ALB Target Groups
  grafana_alb_target_group_key_name = "grafana-tg"

  # ALB Listeners
  grafana_alb_listener_key_name = "grafana-https"

  # ACM Certificates
  grafana_acm_certificate_key_name = "grafana"

  # RDS Sub-module
  rds_port         = 5432
  rds_engine       = "postgres"
  rds_db_name      = "grafana"
  rds_storage_type = "gp2"
}

module "grafana_ecs_deployment" {
  source  = "infraspecdev/ecs-deployment/aws"
  version = "4.3.4"

  vpc_id       = var.vpc_id
  cluster_name = var.cluster_name

  # ECS Service
  service = {
    name          = var.service_name
    desired_count = var.service_desired_count

    load_balancer = [
      {
        target_group   = local.grafana_alb_target_group_key_name
        container_name = local.grafana_container_name
        container_port = local.grafana_port
      }
    ]

    network_configuration = {
      subnets         = var.service_subnet_ids
      security_groups = [module.ecs_service_security_group.security_group_id]
    }

    deployment_circuit_breaker = {
      enable   = true
      rollback = true
    }

    tags = var.service_tags
  }

  # ECS Task Definition
  task_definition = {
    family       = var.task_definition_family
    cpu          = local.task_cpu
    memory       = local.task_memory
    track_latest = true

    task_role_arn      = module.grafana_task_iam_role.arn
    execution_role_arn = module.grafana_execution_iam_role.arn

    runtime_platform = {
      operating_system_family = "LINUX"
      cpu_architecture        = "X86_64"
    }

    container_definitions = [
      {
        name                   = local.grafana_container_name
        image                  = local.grafana_container_image
        cpu                    = local.grafana_container_cpu
        memory                 = local.grafana_container_memory
        essential              = true
        readonlyRootFilesystem = false

        environment = [
          for name, value in local.grafana_container_environment : {
            name  = name
            value = value
          }
        ]
        secrets = [
          for name, valueFrom in local.grafana_container_secrets : {
            name      = name
            valueFrom = valueFrom
          }
        ]

        portMappings = [
          {
            name          = "server"
            containerPort = local.grafana_port
            protocol      = "tcp"
          }
        ]
      }
    ]

    tags = var.task_definition_tags
  }

  # Capacity Provider
  create_capacity_provider = false

  # Application Load Balancer
  load_balancer = {
    name                 = var.alb_name
    internal             = false
    subnets_ids          = var.alb_subnet_ids
    security_groups_ids  = [module.grafana_alb_security_group.security_group_id]
    preserve_host_header = true

    target_groups = {
      (local.grafana_alb_target_group_key_name) = {
        name        = var.alb_target_group_name
        port        = local.grafana_port
        protocol    = "HTTP"
        target_type = "ip"

        health_check = {
          path = "/api/health"
        }

        tags = var.alb_target_group_tags
      }
    }

    listeners = {
      (local.grafana_alb_listener_key_name) = {
        port        = 443
        protocol    = "HTTPS"
        certificate = local.grafana_acm_certificate_key_name

        default_action = [
          {
            type         = "forward"
            target_group = local.grafana_alb_target_group_key_name
          }
        ]

        tags = var.alb_listener_tags
      }
    }

    tags = var.alb_tags
  }

  # S3 Bucket
  s3_bucket_name          = var.s3_bucket_name
  s3_bucket_force_destroy = true
  s3_bucket_tags          = var.s3_bucket_tags

  # ACM
  create_acm = true
  acm_certificates = {
    (local.grafana_acm_certificate_key_name) = {
      domain_name   = var.acm_grafana_domain_name
      key_algorithm = "RSA_2048"
      validation_option = {
        domain_name       = var.acm_grafana_domain_name
        validation_domain = var.acm_grafana_domain_name
      }

      record_zone_id = var.acm_record_zone_id

      tags = var.acm_certificate_tags
    }
  }
}

################################################################################
# IAM Role Sub-module
################################################################################

module "grafana_task_iam_role" {
  source = "./modules/iam-role"

  name        = var.grafana_task_role_name
  description = var.grafana_task_role_description
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  }

  iam_policies = var.grafana_task_role_policies

  tags = var.grafana_task_role_tags
}

module "grafana_execution_iam_role" {
  source = "./modules/iam-role"

  name        = var.grafana_execution_role_name
  description = var.grafana_execution_role_description
  assume_role_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  }

  iam_policies = var.grafana_execution_role_policies

  tags = var.grafana_execution_role_tags
}

################################################################################
# RDS Sub-module
################################################################################

module "grafana_backend_rds" {
  source = "./modules/rds"

  identifier = var.rds_identifier

  instance_class    = var.rds_instance_class
  storage_type      = local.rds_storage_type
  allocated_storage = var.rds_allocated_storage

  engine         = local.rds_engine
  engine_version = var.rds_postgres_engine_version
  vpc_security_group_ids = [
    module.grafana_backend_rds_security_group.security_group_id
  ]
  db_name  = local.rds_db_name
  username = var.rds_username

  db_subnet_group_name        = var.rds_db_subnet_group_name
  db_subnet_group_description = var.rds_db_subnet_group_description
  db_subnet_group_subnet_ids  = var.rds_db_subnet_group_subnet_ids
  db_subnet_group_tags        = var.rds_db_subnet_group_tags

  db_parameter_group_name        = var.rds_db_parameter_group_name
  db_parameter_group_description = var.rds_db_parameter_group_description
  db_parameter_group_family      = var.rds_db_parameter_group_family
  db_parameter_group_parameters  = var.rds_db_parameter_group_parameters
  db_parameter_group_tags        = var.rds_db_parameter_group_tags

  tags = var.rds_tags
}

################################################################################
# Supporting Resources
################################################################################

################################################################################
# # Security Groups
################################################################################

data "aws_vpc" "this" {
  id = var.vpc_id
}

module "ecs_service_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.2"

  name        = "grafana-service"
  description = "Defines ingress and egress rules for ECS Grafana Services"
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      description              = "Allow ingress on Grafana port from ALB"
      from_port                = local.grafana_port
      to_port                  = local.grafana_port
      protocol                 = "tcp"
      source_security_group_id = module.grafana_alb_security_group.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "grafana_alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.2"

  name        = "grafana-alb"
  description = "Defines ingress and egress rules for Grafana ALB."
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      description = "Allow all ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress on Grafana port within VPC"
      from_port   = local.grafana_port
      to_port     = local.grafana_port
      protocol    = "tcp"
      cidr_blocks = data.aws_vpc.this.cidr_block
    }
  ]
}

module "grafana_backend_rds_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.2"

  name        = "grafana-backend"
  description = "Defines ingress and egress rules for Grafana RDS Backend instance."
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      description              = "Allow ingress on Postgres port from ECS Grafana Services"
      from_port                = local.rds_port
      to_port                  = local.rds_port
      protocol                 = "tcp"
      source_security_group_id = module.ecs_service_security_group.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress within VPC"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = data.aws_vpc.this.cidr_block
    }
  ]
}

################################################################################
# # Route53 Record
################################################################################

module "grafana_dns_record" {
  source = "./modules/route-53-record"

  domain       = var.acm_grafana_domain_name
  alb_dns_name = module.grafana_ecs_deployment.alb_dns_name
  alb_zone_id  = module.grafana_ecs_deployment.alb_zone_id
}
