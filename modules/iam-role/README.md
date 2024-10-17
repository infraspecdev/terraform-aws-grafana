<!-- BEGIN_TF_DOCS -->
# iam-role

This sub-module creates an IAM role and attaches appropriate IAM policies to the IAM role.

## Presets

### IAM Role

- The `name` is marked as a required variable, which sets the name of the IAM role.

## Notes

- The IAM policies defined under `iam_policies` are created and automatically attached to the IAM role.
- The ARNs of the IAM policies specified under the `iam_policy_attachments` are automatically attached to the IAM role. This is useful in cases where you are referencing:
  - Amazon-managed IAM Policies, or
  - Self-managed IAM Policies

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
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.iam_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | (Required) Policy that grants an entity permission to assume the role. | `any` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | (Optional, Default:null) Description of the role. | `string` | `null` | no |
| <a name="input_iam_policies"></a> [iam\_policies](#input\_iam\_policies) | (Optional, Default:{}) Map of IAM policies to create and attach to the IAM Role. | <pre>map(<br/>    object({<br/>      name        = string<br/>      description = optional(string, null)<br/>      policy = object({<br/>        Version = optional(string, "2012-10-17")<br/>        Statement = list(<br/>          object({<br/>            Sid      = optional(string)<br/>            Effect   = string<br/>            Resource = string<br/>            Action   = optional(list(string), [])<br/>          })<br/>        )<br/>      })<br/>      tags = optional(map(string), {})<br/>    })<br/>  )</pre> | `{}` | no |
| <a name="input_iam_policy_attachments"></a> [iam\_policy\_attachments](#input\_iam\_policy\_attachments) | (Optional, Default:{}) Map of IAM Policy ARNs to attach to the IAM Role. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required, Forces new resource) Friendly name of the role. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional, Default:{}) Key-value mapping of tags for the IAM role. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) specifying the role. |
| <a name="output_iam_policies_arns"></a> [iam\_policies\_arns](#output\_iam\_policies\_arns) | Map of IAM Policies ARNs. |
| <a name="output_iam_policies_ids"></a> [iam\_policies\_ids](#output\_iam\_policies\_ids) | Map of IAM Policies Identifiers. |
| <a name="output_id"></a> [id](#output\_id) | Name of the role. |
<!-- END_TF_DOCS -->
