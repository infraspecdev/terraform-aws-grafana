resource "aws_db_instance" "this" {
  identifier = var.identifier

  instance_class    = var.instance_class
  storage_type      = var.storage_type
  allocated_storage = var.allocated_storage

  engine                 = var.engine
  engine_version         = var.engine_version
  vpc_security_group_ids = var.vpc_security_group_ids

  db_subnet_group_name = aws_db_subnet_group.this.name
  parameter_group_name = aws_db_parameter_group.this.name

  db_name                     = var.db_name
  username                    = var.username
  manage_master_user_password = true

  skip_final_snapshot = var.skip_final_snapshot

  tags = var.tags
}

################################################################################
# DB Subnet Group
################################################################################

resource "aws_db_subnet_group" "this" {
  name        = var.db_subnet_group_name
  description = var.db_subnet_group_description
  subnet_ids  = var.db_subnet_group_subnet_ids

  tags = var.db_subnet_group_tags
}

################################################################################
# DB Parameter Group
################################################################################

resource "aws_db_parameter_group" "this" {
  name        = var.db_parameter_group_name
  description = var.db_parameter_group_description
  family      = var.db_parameter_group_family

  dynamic "parameter" {
    for_each = var.db_parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = try(parameter.value.apply_method, null)
    }
  }

  tags = var.db_parameter_group_tags
}
