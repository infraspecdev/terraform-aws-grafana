output "id" {
  description = "RDS DBI resource ID."
  value       = aws_db_instance.this.id
}

output "arn" {
  description = "The ARN of the RDS instance."
  value       = aws_db_instance.this.arn
}

output "endpoint" {
  description = "The connection endpoint in `address:port` format."
  value       = aws_db_instance.this.endpoint
}

output "master_user_secret" {
  description = "Details of the secret containing the database master password."
  value       = aws_db_instance.this.master_user_secret[0]
}

################################################################################
# DB Subnet Group
################################################################################

output "db_subnet_group_id" {
  description = "The db subnet group name."
  value       = aws_db_subnet_group.this.id
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group."
  value       = aws_db_subnet_group.this.arn
}

################################################################################
# DB Parameter Group
################################################################################

output "db_parameter_group_id" {
  description = "The db parameter group name."
  value       = aws_db_parameter_group.this.id
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group."
  value       = aws_db_parameter_group.this.arn
}
