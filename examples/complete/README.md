<!-- BEGIN_TF_DOCS -->
# Grafana Complete

Configuration in this directory creates:

- ECS Service in a pre-configured ECS Cluster to deploy Grafana tasks
- ECS Task Definition to run Grafana container
- Application Load Balancer to provide endpoint for accessing the Grafana dashboard, and
- ACM certificate for a domain name to use with the Grafana ALB endpoint

## Example `tfvars` Configuration

```tf
vpc_id       = "vpc-06c3718eeee7ce034"
cluster_name = "default-cluster"

# ECS Service
service_name          = "grafana"
service_subnet_ids             = ["subnet-08a47aaf2e2328e38", "subnet-04017c6ce4c1adaa4"]
service_desired_count = 3
service_tags          = {}

# ECS Task Definition
task_definition_family                = "grafana"
task_definition_grafana_image_version = "11.1.2"
task_definition_tags                  = {}

# ALB
alb_name              = "grafana-alb"
alb_subnet_ids                 = ["subnet-00e0e78571726e5c1", "subnet-00ec7b7882cfb78b1"]
alb_tags              = {}
alb_target_group_name = "grafana-services"
alb_target_group_tags = {}
alb_listener_tags     = {}

# S3 Bucket
s3_bucket_name = "grafana-services-alb-logs"
s3_bucket_tags = {}

# ACM
acm_grafana_domain_name        = "grafana.gaussb.io"
acm_record_zone_id             = "Z0105802SJKE46BQ70GU"
acm_certificate_tags = {}

# Grafana Task IAM Role
grafana_task_role_name        = "grafana-task-iam-role"
grafana_task_role_description = "Managed By Terraform"
grafana_task_role_policies = {
  rds = {
    name        = "grafana-task-iam-role-rds"
    description = "Allow access to RDS"
    policy = {
      Statement = [
        {
          Sid      = "AllowRDSFullAccess"
          Effect   = "Allow"
          Resource = "*"
          Action   = ["rds:*"]
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
          Sid      = "AllowAthenaFullAccess"
          Effect   = "Allow"
          Resource = "*"
          Action   = ["athena:*"]
        },
        {
          Sid    = "AllowGlueFullAccess"
          Effect = "Allow"
          Action = [
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
          ]
          Resource = "*"
        }
      ]
    }
  }
}
grafana_task_role_tags = {}

# Grafana Task Execution IAM Role
grafana_execution_role_name        = "grafana-task-execution-iam-role"
grafana_execution_role_description = "Managed By Terraform"
grafana_execution_role_policies = {
  secrets-manager = {
    name        = "grafana-execution-role-secrets-manager"
    description = "Allow access to Secrets Manager"
    policy = {
      Statement = [
        {
          Sid      = "AllowSecretsManagerFullAccess"
          Effect   = "Allow"
          Resource = "*"
          Action   = ["secretsmanager:*"]
        }
      ]
    }
  }
}
grafana_execution_role_tags = {}

# RDS
rds_identifier                     = "grafana-backend"
rds_instance_class                 = "db.t3.micro"
rds_allocated_storage              = 10
rds_postgres_engine_version        = "16.3"
rds_username                       = "grafana_admin"
rds_tags                           = {}
rds_db_subnet_group_name           = "grafana-rds-subnet-group"
rds_db_subnet_group_description    = "Managed By Terraform"
rds_db_subnet_group_subnet_ids = ["subnet-08a47aaf2e2328e38", "subnet-04017c6ce4c1adaa4"]
rds_db_subnet_group_tags           = {}
rds_db_parameter_group_name        = "grafana-rds-parameter-group"
rds_db_parameter_group_description = "Managed By Terraform"
rds_db_parameter_group_family      = "postgres16"
rds_db_parameter_group_parameters = [
  {
    name         = "rds.force_ssl"
    value        = "0"
    apply_method = "immediate"
  }
]
rds_db_parameter_group_tags = {}
```

## Usage

To run this example, you will need to execute the commands:

```bash
terraform init
terraform plan
terraform apply
```

Please note that this example may create resources that can incur monetary charges on your AWS bill. You can run `terraform destroy` when you no longer need the resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.4 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_grafana"></a> [grafana](#module\_grafana) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_tags"></a> [acm\_certificate\_tags](#input\_acm\_certificate\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_acm_grafana_domain_name"></a> [acm\_grafana\_domain\_name](#input\_acm\_grafana\_domain\_name) | Grafana domain name for which the certificate should be issued. | `string` | n/a | yes |
| <a name="input_acm_record_zone_id"></a> [acm\_record\_zone\_id](#input\_acm\_record\_zone\_id) | Canonical hosted zone ID of the Load Balancer. | `string` | n/a | yes |
| <a name="input_alb_listener_tags"></a> [alb\_listener\_tags](#input\_alb\_listener\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Name of the LB. | `string` | n/a | yes |
| <a name="input_alb_subnet_ids"></a> [alb\_subnet\_ids](#input\_alb\_subnet\_ids) | List of public VPC subnet IDs where the Application Load Balancer will be configured. | `list(string)` | n/a | yes |
| <a name="input_alb_tags"></a> [alb\_tags](#input\_alb\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_alb_target_group_name"></a> [alb\_target\_group\_name](#input\_alb\_target\_group\_name) | Name of the target group. | `string` | n/a | yes |
| <a name="input_alb_target_group_tags"></a> [alb\_target\_group\_tags](#input\_alb\_target\_group\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster. | `string` | n/a | yes |
| <a name="input_grafana_execution_role_description"></a> [grafana\_execution\_role\_description](#input\_grafana\_execution\_role\_description) | Description of the IAM role for Grafana task execution. | `string` | n/a | yes |
| <a name="input_grafana_execution_role_name"></a> [grafana\_execution\_role\_name](#input\_grafana\_execution\_role\_name) | Friendly name of the IAM role for Grafana task execution. | `string` | n/a | yes |
| <a name="input_grafana_execution_role_policies"></a> [grafana\_execution\_role\_policies](#input\_grafana\_execution\_role\_policies) | Map of IAM policies to create and attach to the Grafana Execution IAM Role. | <pre>map(<br/>    object({<br/>      name        = string<br/>      description = optional(string, null)<br/>      policy = object({<br/>        Version = optional(string, "2012-10-17")<br/>        Statement = list(<br/>          object({<br/>            Sid      = optional(string)<br/>            Effect   = string<br/>            Resource = string<br/>            Action   = optional(list(string), [])<br/>          })<br/>        )<br/>      })<br/>      tags = optional(map(string), {})<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_grafana_execution_role_tags"></a> [grafana\_execution\_role\_tags](#input\_grafana\_execution\_role\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_grafana_task_role_description"></a> [grafana\_task\_role\_description](#input\_grafana\_task\_role\_description) | Description of the IAM role for Grafana tasks. | `string` | n/a | yes |
| <a name="input_grafana_task_role_name"></a> [grafana\_task\_role\_name](#input\_grafana\_task\_role\_name) | Friendly name of the IAM role for Grafana tasks. | `string` | n/a | yes |
| <a name="input_grafana_task_role_policies"></a> [grafana\_task\_role\_policies](#input\_grafana\_task\_role\_policies) | Map of IAM policies to create and attach to the Grafana IAM Role. | <pre>map(<br/>    object({<br/>      name        = string<br/>      description = optional(string, null)<br/>      policy = object({<br/>        Version = optional(string, "2012-10-17")<br/>        Statement = list(<br/>          object({<br/>            Sid      = optional(string)<br/>            Effect   = string<br/>            Resource = string<br/>            Action   = optional(list(string), [])<br/>          })<br/>        )<br/>      })<br/>      tags = optional(map(string), {})<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_grafana_task_role_tags"></a> [grafana\_task\_role\_tags](#input\_grafana\_task\_role\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | The allocated storage in gibibytes. | `number` | n/a | yes |
| <a name="input_rds_db_parameter_group_description"></a> [rds\_db\_parameter\_group\_description](#input\_rds\_db\_parameter\_group\_description) | The description of the DB parameter group. | `string` | n/a | yes |
| <a name="input_rds_db_parameter_group_family"></a> [rds\_db\_parameter\_group\_family](#input\_rds\_db\_parameter\_group\_family) | The description of the DB parameter group. | `string` | n/a | yes |
| <a name="input_rds_db_parameter_group_name"></a> [rds\_db\_parameter\_group\_name](#input\_rds\_db\_parameter\_group\_name) | The name of the DB parameter group. | `string` | n/a | yes |
| <a name="input_rds_db_parameter_group_parameters"></a> [rds\_db\_parameter\_group\_parameters](#input\_rds\_db\_parameter\_group\_parameters) | The DB parameters to apply. | <pre>list(<br/>    object({<br/>      name         = string<br/>      value        = string<br/>      apply_method = optional(string)<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_rds_db_parameter_group_tags"></a> [rds\_db\_parameter\_group\_tags](#input\_rds\_db\_parameter\_group\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_rds_db_subnet_group_description"></a> [rds\_db\_subnet\_group\_description](#input\_rds\_db\_subnet\_group\_description) | The description of the DB subnet group. | `string` | n/a | yes |
| <a name="input_rds_db_subnet_group_name"></a> [rds\_db\_subnet\_group\_name](#input\_rds\_db\_subnet\_group\_name) | The name of the DB subnet group. | `string` | n/a | yes |
| <a name="input_rds_db_subnet_group_subnet_ids"></a> [rds\_db\_subnet\_group\_subnet\_ids](#input\_rds\_db\_subnet\_group\_subnet\_ids) | A list of VPC subnet IDs. | `list(string)` | n/a | yes |
| <a name="input_rds_db_subnet_group_tags"></a> [rds\_db\_subnet\_group\_tags](#input\_rds\_db\_subnet\_group\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_rds_identifier"></a> [rds\_identifier](#input\_rds\_identifier) | The name of the Postgres RDS instance. | `string` | n/a | yes |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The instance type of the Postgres RDS instance. | `string` | n/a | yes |
| <a name="input_rds_postgres_engine_version"></a> [rds\_postgres\_engine\_version](#input\_rds\_postgres\_engine\_version) | The Postgres engine version to use. | `string` | n/a | yes |
| <a name="input_rds_tags"></a> [rds\_tags](#input\_rds\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | Username for the master DB user. | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of the bucket where the Grafana ALB logs will be stored. | `string` | n/a | yes |
| <a name="input_s3_bucket_tags"></a> [s3\_bucket\_tags](#input\_s3\_bucket\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | Desired number of tasks to run in the ECS Service. | `number` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the ECS Service. | `string` | n/a | yes |
| <a name="input_service_subnet_ids"></a> [service\_subnet\_ids](#input\_service\_subnet\_ids) | List of VPC subnet IDs where the infrastructure will be configured. | `list(string)` | n/a | yes |
| <a name="input_service_tags"></a> [service\_tags](#input\_service\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_task_definition_family"></a> [task\_definition\_family](#input\_task\_definition\_family) | A unique name for your task definition. | `string` | n/a | yes |
| <a name="input_task_definition_grafana_image_version"></a> [task\_definition\_grafana\_image\_version](#input\_task\_definition\_grafana\_image\_version) | Version tag to use with the Grafana docker image. | `string` | n/a | yes |
| <a name="input_task_definition_tags"></a> [task\_definition\_tags](#input\_task\_definition\_tags) | Map of Resources Tags to attach to the resource. | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | ARN of the ACM certificate for Grafana endpoint. |
| <a name="output_acm_certificate_id"></a> [acm\_certificate\_id](#output\_acm\_certificate\_id) | Identifier of the ACM certificate for Grafana endpoint. |
| <a name="output_acm_certificate_validation_id"></a> [acm\_certificate\_validation\_id](#output\_acm\_certificate\_validation\_id) | Identifier of the Grafana endpoint ACM certificate validation resource. |
| <a name="output_acm_route53_record_id"></a> [acm\_route53\_record\_id](#output\_acm\_route53\_record\_id) | Identifier of the Route53 Record for validation of the Grafana endpoint ACM certificate. |
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | ARN of the Grafana load balancer. |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | DNS name of the Grafana load balancer. |
| <a name="output_alb_listener_arn"></a> [alb\_listener\_arn](#output\_alb\_listener\_arn) | ARN of the Listener for Grafana services. |
| <a name="output_alb_listener_id"></a> [alb\_listener\_id](#output\_alb\_listener\_id) | Identifier of the Listener for Grafana services. |
| <a name="output_alb_target_group_arn"></a> [alb\_target\_group\_arn](#output\_alb\_target\_group\_arn) | ARN of the Target Group of Grafana services. |
| <a name="output_alb_target_group_id"></a> [alb\_target\_group\_id](#output\_alb\_target\_group\_id) | Identifier of the Target Group of Grafana services. |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | Canonical hosted zone ID of the Grafana Load Balancer. |
| <a name="output_ecs_service_security_group_arn"></a> [ecs\_service\_security\_group\_arn](#output\_ecs\_service\_security\_group\_arn) | ARN of the Grafana ECS Service Security Group. |
| <a name="output_ecs_service_security_group_id"></a> [ecs\_service\_security\_group\_id](#output\_ecs\_service\_security\_group\_id) | Identifier of the Grafana ECS Service Security Group. |
| <a name="output_grafana_alb_security_group_arn"></a> [grafana\_alb\_security\_group\_arn](#output\_grafana\_alb\_security\_group\_arn) | ARN of the Grafana ALB Security Group. |
| <a name="output_grafana_alb_security_group_id"></a> [grafana\_alb\_security\_group\_id](#output\_grafana\_alb\_security\_group\_id) | Identifier of the Grafana ALB Security Group. |
| <a name="output_grafana_backend_rds_security_group_arn"></a> [grafana\_backend\_rds\_security\_group\_arn](#output\_grafana\_backend\_rds\_security\_group\_arn) | ARN of the Grafana Backend RDS Security Group. |
| <a name="output_grafana_backend_rds_security_group_id"></a> [grafana\_backend\_rds\_security\_group\_id](#output\_grafana\_backend\_rds\_security\_group\_id) | Identifier of the Grafana Backend RDS Security Group. |
| <a name="output_grafana_ecs_service_arn"></a> [grafana\_ecs\_service\_arn](#output\_grafana\_ecs\_service\_arn) | ARN that identifies the Grafana ECS service. |
| <a name="output_grafana_ecs_task_definition_arn"></a> [grafana\_ecs\_task\_definition\_arn](#output\_grafana\_ecs\_task\_definition\_arn) | Full ARN of the Grafana ECS Task Definition. |
| <a name="output_grafana_execution_iam_role_arn"></a> [grafana\_execution\_iam\_role\_arn](#output\_grafana\_execution\_iam\_role\_arn) | Amazon Resource Name (ARN) specifying the Grafana Execution IAM role. |
| <a name="output_grafana_execution_iam_role_id"></a> [grafana\_execution\_iam\_role\_id](#output\_grafana\_execution\_iam\_role\_id) | Name of the Grafana Execution IAM role. |
| <a name="output_grafana_execution_iam_role_policies_arns"></a> [grafana\_execution\_iam\_role\_policies\_arns](#output\_grafana\_execution\_iam\_role\_policies\_arns) | Map of IAM Policies ARNs created and attached with the Grafana Execution IAM role. |
| <a name="output_grafana_execution_iam_role_policies_ids"></a> [grafana\_execution\_iam\_role\_policies\_ids](#output\_grafana\_execution\_iam\_role\_policies\_ids) | Map of IAM Policies Identifiers created and attached with the Grafana Execution IAM role. |
| <a name="output_grafana_task_iam_role_arn"></a> [grafana\_task\_iam\_role\_arn](#output\_grafana\_task\_iam\_role\_arn) | Amazon Resource Name (ARN) specifying the Grafana Task IAM role. |
| <a name="output_grafana_task_iam_role_id"></a> [grafana\_task\_iam\_role\_id](#output\_grafana\_task\_iam\_role\_id) | Name of the Grafana Task IAM role. |
| <a name="output_grafana_task_iam_role_policies_arns"></a> [grafana\_task\_iam\_role\_policies\_arns](#output\_grafana\_task\_iam\_role\_policies\_arns) | Map of IAM Policies ARNs created and attached with the Grafana Task IAM role. |
| <a name="output_grafana_task_iam_role_policies_ids"></a> [grafana\_task\_iam\_role\_policies\_ids](#output\_grafana\_task\_iam\_role\_policies\_ids) | Map of IAM Policies Identifiers created and attached with the Grafana Task IAM role. |
| <a name="output_rds_arn"></a> [rds\_arn](#output\_rds\_arn) | The ARN of the Grafana RDS instance. |
| <a name="output_rds_db_parameter_group_arn"></a> [rds\_db\_parameter\_group\_arn](#output\_rds\_db\_parameter\_group\_arn) | The ARN of the db parameter group attached with Grafana RDS. |
| <a name="output_rds_db_parameter_group_id"></a> [rds\_db\_parameter\_group\_id](#output\_rds\_db\_parameter\_group\_id) | The db parameter group name to use with the Grafana RDS. |
| <a name="output_rds_db_subnet_group_arn"></a> [rds\_db\_subnet\_group\_arn](#output\_rds\_db\_subnet\_group\_arn) | The ARN of the db subnet group attached with Grafana RDS. |
| <a name="output_rds_db_subnet_group_id"></a> [rds\_db\_subnet\_group\_id](#output\_rds\_db\_subnet\_group\_id) | The db subnet group name to use with the Grafana RDS. |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | The Grafana RDS connection endpoint in `address:port` format. |
| <a name="output_rds_id"></a> [rds\_id](#output\_rds\_id) | Grafana RDS DBI resource ID. |
| <a name="output_rds_master_user_secret"></a> [rds\_master\_user\_secret](#output\_rds\_master\_user\_secret) | Details of the secret containing the database master password for Grafana RDS. |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | ARN of the bucket where the Grafana ALB logs will be stored. |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | Name of the bucket where the Grafana ALB logs will be stored. |
<!-- END_TF_DOCS -->
