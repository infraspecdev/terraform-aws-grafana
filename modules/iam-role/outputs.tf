output "id" {
  description = "Name of the role."
  value       = aws_iam_role.this.id
}

output "arn" {
  description = "Amazon Resource Name (ARN) specifying the role."
  value       = aws_iam_role.this.arn
}

################################################################################
# IAM Policy
################################################################################

output "iam_policies_ids" {
  description = "Map of IAM Policies Identifiers."
  value       = { for name, iam_policy in aws_iam_policy.this : name => iam_policy.id }
}

output "iam_policies_arns" {
  description = "Map of IAM Policies ARNs."
  value       = { for name, iam_policy in aws_iam_policy.this : name => iam_policy.arn }
}
