<!-- BEGIN_TF_DOCS -->
# rds

This sub-module creates an RDS instance.

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | (Required) The allocated storage in gibibytes. | `number` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | (Optional, Default:default\_db) The database name. | `string` | `"default_db"` | no |
| <a name="input_db_parameter_group_description"></a> [db\_parameter\_group\_description](#input\_db\_parameter\_group\_description) | (Optional, Default:"Managed By Terraform", Forces new resource) The description of the DB parameter group. | `string` | `"Managed By Terraform"` | no |
| <a name="input_db_parameter_group_family"></a> [db\_parameter\_group\_family](#input\_db\_parameter\_group\_family) | (Required, Forces new resource) The family of the DB parameter group. | `string` | n/a | yes |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | (Required, Forces new resource) The name of the DB parameter group. | `string` | n/a | yes |
| <a name="input_db_parameter_group_parameters"></a> [db\_parameter\_group\_parameters](#input\_db\_parameter\_group\_parameters) | (Optional, Default:[]) The DB parameters to apply. | <pre>list(<br>    object({<br>      name         = string<br>      value        = string<br>      apply_method = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_db_parameter_group_tags"></a> [db\_parameter\_group\_tags](#input\_db\_parameter\_group\_tags) | (Optional, Default:{}) A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_db_subnet_group_description"></a> [db\_subnet\_group\_description](#input\_db\_subnet\_group\_description) | (Optional, Default:"Managed By Terraform", Forces new resource) The description of the DB subnet group. | `string` | `"Managed By Terraform"` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | (Required, Forces new resource) The name of the DB subnet group. | `string` | n/a | yes |
| <a name="input_db_subnet_group_subnet_ids"></a> [db\_subnet\_group\_subnet\_ids](#input\_db\_subnet\_group\_subnet\_ids) | (Required) A list of VPC subnet IDs. | `list(string)` | n/a | yes |
| <a name="input_db_subnet_group_tags"></a> [db\_subnet\_group\_tags](#input\_db\_subnet\_group\_tags) | (Optional, Default:{}) A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Optional, Default:null) The database engine. | `string` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional, Default:null) The engine version to use. | `string` | `null` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | (Required) The name of the RDS instance. | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | (Required) The instance type of the RDS instance. | `string` | n/a | yes |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | (Optional, Default:true) Determines whether a final DB snapshot is created before the DB instance is deleted. | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | (Optional, Default:"gp2") One of "standard", "gp2", "gp3" or "io1". | `string` | `"gp2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | (Optional, Default:admin\_user) Username for the master DB user. | `string` | `"admin_user"` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | (Optional) List of VPC security groups to associate. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the RDS instance. |
| <a name="output_db_parameter_group_arn"></a> [db\_parameter\_group\_arn](#output\_db\_parameter\_group\_arn) | The ARN of the db parameter group. |
| <a name="output_db_parameter_group_id"></a> [db\_parameter\_group\_id](#output\_db\_parameter\_group\_id) | The db parameter group name. |
| <a name="output_db_subnet_group_arn"></a> [db\_subnet\_group\_arn](#output\_db\_subnet\_group\_arn) | The ARN of the db subnet group. |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | The db subnet group name. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The connection endpoint in `address:port` format. |
| <a name="output_id"></a> [id](#output\_id) | RDS DBI resource ID. |
| <a name="output_master_user_secret"></a> [master\_user\_secret](#output\_master\_user\_secret) | Details of the secret containing the database master password. |
<!-- END_TF_DOCS -->
