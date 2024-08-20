<!-- BEGIN_TF_DOCS -->
# Grafana Minimal

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
service_subnet_ids             = ["subnet-08a47aaf2e2328e38", "subnet-04017c6ce4c1adaa4"]

# ALB
alb_subnet_ids                 = ["subnet-00e0e78571726e5c1", "subnet-00ec7b7882cfb78b1"]

# ACM
acm_grafana_domain_name        = "grafana.gaussb.io"
acm_record_zone_id             = "Z0105802SJKE46BQ70GU"

# RDS
rds_db_subnet_group_subnet_ids = ["subnet-08a47aaf2e2328e38", "subnet-04017c6ce4c1adaa4"]
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
| <a name="input_acm_grafana_domain_name"></a> [acm\_grafana\_domain\_name](#input\_acm\_grafana\_domain\_name) | Grafana domain name for which the certificate should be issued. | `string` | n/a | yes |
| <a name="input_acm_record_zone_id"></a> [acm\_record\_zone\_id](#input\_acm\_record\_zone\_id) | Canonical hosted zone ID of the Load Balancer. | `string` | n/a | yes |
| <a name="input_alb_subnet_ids"></a> [alb\_subnet\_ids](#input\_alb\_subnet\_ids) | List of public VPC subnet IDs where the Application Load Balancer will be configured. | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster. | `string` | n/a | yes |
| <a name="input_rds_db_subnet_group_subnet_ids"></a> [rds\_db\_subnet\_group\_subnet\_ids](#input\_rds\_db\_subnet\_group\_subnet\_ids) | A list of VPC subnet IDs. | `list(string)` | n/a | yes |
| <a name="input_service_subnet_ids"></a> [service\_subnet\_ids](#input\_service\_subnet\_ids) | List of VPC subnet IDs where the infrastructure will be configured. | `list(string)` | n/a | yes |
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
