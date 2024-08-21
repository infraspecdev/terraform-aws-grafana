<!-- BEGIN_TF_DOCS -->
# terraform-aws-grafana

Terraform module to deploy Grafana on ECS.

## Architecture Diagram

![Grafana Architecture Diagram](https://github.com/infraspecdev/terraform-aws-grafana/raw/main/diagrams/grafana-architecture.png)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_service_security_group"></a> [ecs\_service\_security\_group](#module\_ecs\_service\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.1.2 |
| <a name="module_grafana_alb_security_group"></a> [grafana\_alb\_security\_group](#module\_grafana\_alb\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.1.2 |
| <a name="module_grafana_backend_rds"></a> [grafana\_backend\_rds](#module\_grafana\_backend\_rds) | ./modules/rds | n/a |
| <a name="module_grafana_backend_rds_security_group"></a> [grafana\_backend\_rds\_security\_group](#module\_grafana\_backend\_rds\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.1.2 |
| <a name="module_grafana_dns_record"></a> [grafana\_dns\_record](#module\_grafana\_dns\_record) | ./modules/route-53-record | n/a |
| <a name="module_grafana_ecs_deployment"></a> [grafana\_ecs\_deployment](#module\_grafana\_ecs\_deployment) | infraspecdev/ecs-deployment/aws | 4.3.4 |
| <a name="module_grafana_execution_iam_role"></a> [grafana\_execution\_iam\_role](#module\_grafana\_execution\_iam\_role) | ./modules/iam-role | n/a |
| <a name="module_grafana_task_iam_role"></a> [grafana\_task\_iam\_role](#module\_grafana\_task\_iam\_role) | ./modules/iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_tags"></a> [acm\_certificate\_tags](#input\_acm\_certificate\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_acm_grafana_domain_name"></a> [acm\_grafana\_domain\_name](#input\_acm\_grafana\_domain\_name) | (Required) Grafana domain name for which the certificate should be issued. | `string` | n/a | yes |
| <a name="input_acm_record_zone_id"></a> [acm\_record\_zone\_id](#input\_acm\_record\_zone\_id) | (Required) Canonical hosted zone ID of the Load Balancer. | `string` | n/a | yes |
| <a name="input_alb_listener_tags"></a> [alb\_listener\_tags](#input\_alb\_listener\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | (Optional, Default:"grafana-alb") Name of the LB. | `string` | `"grafana-alb"` | no |
| <a name="input_alb_subnet_ids"></a> [alb\_subnet\_ids](#input\_alb\_subnet\_ids) | (Required) List of public VPC subnet IDs where the Application Load Balancer will be configured. | `list(string)` | n/a | yes |
| <a name="input_alb_tags"></a> [alb\_tags](#input\_alb\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_alb_target_group_name"></a> [alb\_target\_group\_name](#input\_alb\_target\_group\_name) | (Optional, Default:"grafana-services", Forces new resource) Name of the target group. | `string` | `"grafana-services"` | no |
| <a name="input_alb_target_group_tags"></a> [alb\_target\_group\_tags](#input\_alb\_target\_group\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | (Required) Name of the cluster. | `string` | n/a | yes |
| <a name="input_grafana_execution_role_description"></a> [grafana\_execution\_role\_description](#input\_grafana\_execution\_role\_description) | (Optional, Default:"Managed By Terraform") Description of the IAM role for Grafana task execution. | `string` | `"Managed By Terraform"` | no |
| <a name="input_grafana_execution_role_name"></a> [grafana\_execution\_role\_name](#input\_grafana\_execution\_role\_name) | (Optional, Default:"grafana-task-execution-iam-role", Forces new resource) Friendly name of the IAM role for Grafana task execution. | `string` | `"grafana-task-execution-iam-role"` | no |
| <a name="input_grafana_execution_role_policies"></a> [grafana\_execution\_role\_policies](#input\_grafana\_execution\_role\_policies) | (Optional, Default:secrets-manager) Map of IAM policies to create and attach to the Grafana Execution IAM Role. | <pre>map(<br>    object({<br>      name        = string<br>      description = optional(string, null)<br>      policy = object({<br>        Version = optional(string, "2012-10-17")<br>        Statement = list(<br>          object({<br>            Sid      = optional(string)<br>            Effect   = string<br>            Resource = string<br>            Action   = optional(list(string), [])<br>          })<br>        )<br>      })<br>      tags = optional(map(string), {})<br>    })<br>  )</pre> | <pre>{<br>  "secrets-manager": {<br>    "description": "Allow access to Secrets Manager",<br>    "name": "grafana-execution-role-secrets-manager",<br>    "policy": {<br>      "Statement": [<br>        {<br>          "Action": [<br>            "secretsmanager:*"<br>          ],<br>          "Effect": "Allow",<br>          "Resource": "*",<br>          "Sid": "AllowSecretsManagerFullAccess"<br>        }<br>      ]<br>    }<br>  }<br>}</pre> | no |
| <a name="input_grafana_execution_role_tags"></a> [grafana\_execution\_role\_tags](#input\_grafana\_execution\_role\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_grafana_task_role_description"></a> [grafana\_task\_role\_description](#input\_grafana\_task\_role\_description) | (Optional, Default:"Managed By Terraform") Description of the IAM role for Grafana tasks. | `string` | `"Managed By Terraform"` | no |
| <a name="input_grafana_task_role_name"></a> [grafana\_task\_role\_name](#input\_grafana\_task\_role\_name) | (Optional, Default:"grafana-task-iam-role", Forces new resource) Friendly name of the IAM role for Grafana tasks. | `string` | `"grafana-task-iam-role"` | no |
| <a name="input_grafana_task_role_policies"></a> [grafana\_task\_role\_policies](#input\_grafana\_task\_role\_policies) | (Optional, Default:rds,athena) Map of IAM policies to create and attach to the Grafana IAM Role. | <pre>map(<br>    object({<br>      name        = string<br>      description = optional(string, null)<br>      policy = object({<br>        Version = optional(string, "2012-10-17")<br>        Statement = list(<br>          object({<br>            Sid      = optional(string)<br>            Effect   = string<br>            Resource = string<br>            Action   = optional(list(string), [])<br>          })<br>        )<br>      })<br>      tags = optional(map(string), {})<br>    })<br>  )</pre> | <pre>{<br>  "athena": {<br>    "description": "Allow access to Athena",<br>    "name": "grafana-task-iam-role-athena",<br>    "policy": {<br>      "Statement": [<br>        {<br>          "Action": [<br>            "athena:*"<br>          ],<br>          "Effect": "Allow",<br>          "Resource": "*",<br>          "Sid": "AllowAthenaFullAccess"<br>        },<br>        {<br>          "Action": [<br>            "glue:CreateDatabase",<br>            "glue:DeleteDatabase",<br>            "glue:GetDatabase",<br>            "glue:GetDatabases",<br>            "glue:UpdateDatabase",<br>            "glue:CreateTable",<br>            "glue:DeleteTable",<br>            "glue:BatchDeleteTable",<br>            "glue:UpdateTable",<br>            "glue:GetTable",<br>            "glue:GetTables",<br>            "glue:BatchCreatePartition",<br>            "glue:CreatePartition",<br>            "glue:DeletePartition",<br>            "glue:BatchDeletePartition",<br>            "glue:UpdatePartition",<br>            "glue:GetPartition",<br>            "glue:GetPartitions",<br>            "glue:BatchGetPartition",<br>            "glue:StartColumnStatisticsTaskRun",<br>            "glue:GetColumnStatisticsTaskRun",<br>            "glue:GetColumnStatisticsTaskRuns",<br>            "glue:GetCatalogImportStatus"<br>          ],<br>          "Effect": "Allow",<br>          "Resource": "*",<br>          "Sid": "AllowGlueFullAccess"<br>        }<br>      ]<br>    }<br>  },<br>  "rds": {<br>    "description": "Allow access to RDS",<br>    "name": "grafana-task-iam-role-rds",<br>    "policy": {<br>      "Statement": [<br>        {<br>          "Action": [<br>            "rds:*"<br>          ],<br>          "Effect": "Allow",<br>          "Resource": "*",<br>          "Sid": "AllowRDSFullAccess"<br>        }<br>      ]<br>    }<br>  }<br>}</pre> | no |
| <a name="input_grafana_task_role_tags"></a> [grafana\_task\_role\_tags](#input\_grafana\_task\_role\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | (Optional, Default:10) The allocated storage in gibibytes. | `number` | `10` | no |
| <a name="input_rds_db_parameter_group_description"></a> [rds\_db\_parameter\_group\_description](#input\_rds\_db\_parameter\_group\_description) | (Optional, Default:"Managed By Terraform", Forces new resource) The description of the DB parameter group. | `string` | `"Managed By Terraform"` | no |
| <a name="input_rds_db_parameter_group_family"></a> [rds\_db\_parameter\_group\_family](#input\_rds\_db\_parameter\_group\_family) | (Optional, Default:"postgres16", Forces new resource) The description of the DB parameter group. | `string` | `"postgres16"` | no |
| <a name="input_rds_db_parameter_group_name"></a> [rds\_db\_parameter\_group\_name](#input\_rds\_db\_parameter\_group\_name) | (Optional, Default:"grafana-rds-parameter-group", Forces new resource) The name of the DB parameter group. | `string` | `"grafana-rds-parameter-group"` | no |
| <a name="input_rds_db_parameter_group_parameters"></a> [rds\_db\_parameter\_group\_parameters](#input\_rds\_db\_parameter\_group\_parameters) | (Optional) The DB parameters to apply. | <pre>list(<br>    object({<br>      name         = string<br>      value        = string<br>      apply_method = optional(string)<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "apply_method": "immediate",<br>    "name": "rds.force_ssl",<br>    "value": "0"<br>  }<br>]</pre> | no |
| <a name="input_rds_db_parameter_group_tags"></a> [rds\_db\_parameter\_group\_tags](#input\_rds\_db\_parameter\_group\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_rds_db_subnet_group_description"></a> [rds\_db\_subnet\_group\_description](#input\_rds\_db\_subnet\_group\_description) | (Optional, Default:"Managed By Terraform", Forces new resource) The description of the DB subnet group. | `string` | `"Managed By Terraform"` | no |
| <a name="input_rds_db_subnet_group_name"></a> [rds\_db\_subnet\_group\_name](#input\_rds\_db\_subnet\_group\_name) | (Optional, Default:"grafana-rds-subnet-group", Forces new resource) The name of the DB subnet group. | `string` | `"grafana-rds-subnet-group"` | no |
| <a name="input_rds_db_subnet_group_subnet_ids"></a> [rds\_db\_subnet\_group\_subnet\_ids](#input\_rds\_db\_subnet\_group\_subnet\_ids) | (Required) A list of VPC subnet IDs. | `list(string)` | n/a | yes |
| <a name="input_rds_db_subnet_group_tags"></a> [rds\_db\_subnet\_group\_tags](#input\_rds\_db\_subnet\_group\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_rds_identifier"></a> [rds\_identifier](#input\_rds\_identifier) | (Optional, Default:"grafana-backend") The name of the Postgres RDS instance. | `string` | `"grafana-backend"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | (Optional, Default:"db.t3.micro") The instance type of the Postgres RDS instance. | `string` | `"db.t3.micro"` | no |
| <a name="input_rds_postgres_engine_version"></a> [rds\_postgres\_engine\_version](#input\_rds\_postgres\_engine\_version) | (Optional, Default:"16.3") The Postgres engine version to use. | `string` | `"16.3"` | no |
| <a name="input_rds_tags"></a> [rds\_tags](#input\_rds\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | (Optional, Default:"grafana\_admin") Username for the master DB user. | `string` | `"grafana_admin"` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | (Optional, Default:"grafana-services-alb-logs", Forces new resource) Name of the bucket where the Grafana ALB logs will be stored. | `string` | `"grafana-services-alb-logs"` | no |
| <a name="input_s3_bucket_tags"></a> [s3\_bucket\_tags](#input\_s3\_bucket\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | (Optional, Default:3) Desired number of tasks to run in the ECS Service. | `number` | `3` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | (Optional, Default:grafana) Name of the ECS Service. | `string` | `"grafana"` | no |
| <a name="input_service_subnet_ids"></a> [service\_subnet\_ids](#input\_service\_subnet\_ids) | (Required) List of VPC subnet IDs where the infrastructure will be configured. | `list(string)` | n/a | yes |
| <a name="input_service_tags"></a> [service\_tags](#input\_service\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_task_definition_family"></a> [task\_definition\_family](#input\_task\_definition\_family) | (Optional, Default:"grafana") A unique name for your task definition. | `string` | `"grafana"` | no |
| <a name="input_task_definition_grafana_image_version"></a> [task\_definition\_grafana\_image\_version](#input\_task\_definition\_grafana\_image\_version) | (Optional, Default:11.1.2) Version tag to use with the Grafana docker image. | `string` | `"11.1.2"` | no |
| <a name="input_task_definition_tags"></a> [task\_definition\_tags](#input\_task\_definition\_tags) | (Optional, Default:{}) Map of Resources Tags to attach to the resource. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Required) The ID of the VPC. | `string` | n/a | yes |

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
