provider "aws" {
  region = "ap-south-1"
}

################################################################################
# DB Instance
################################################################################

run "db_instance_attributes_match" {
  command = plan

  module {
    source = "./modules/rds"
  }

  variables {
    identifier          = "example-identifier"
    instance_class      = "example-instance-class"
    allocated_storage   = 1234
    engine              = "example-engine"
    engine_version      = "example-engine-version"
    vpc_security_group_ids = ["sg-1234567890abcdef"]
    db_name             = "example-db-name"
    username            = "example-username"
    skip_final_snapshot = true

    db_subnet_group_name = "example-db-subnet-group-name"
    db_subnet_group_subnet_ids = ["subnet-1234567890abcdef"]

    db_parameter_group_name   = "example-db-parameter-group-name"
    db_parameter_group_family = "example-db-parameter-group-family"

    tags = {
      Example = "Tag"
    }
  }

  assert {
    condition     = aws_db_instance.this.identifier == var.identifier
    error_message = "Identifier mismatch"
  }

  assert {
    condition     = aws_db_instance.this.instance_class == var.instance_class
    error_message = "Instance class mismatch"
  }

  assert {
    condition     = aws_db_instance.this.storage_type == var.storage_type
    error_message = "Storage type mismatch"
  }

  assert {
    condition     = aws_db_instance.this.allocated_storage == var.allocated_storage
    error_message = "Allocated storage mismatch"
  }

  assert {
    condition     = aws_db_instance.this.engine == var.engine
    error_message = "Engine mismatch"
  }

  assert {
    condition     = aws_db_instance.this.engine_version == var.engine_version
    error_message = "Engine version mismatch"
  }

  assert {
    condition     = aws_db_instance.this.vpc_security_group_ids == toset(var.vpc_security_group_ids)
    error_message = "VPC security group ids mismatch"
  }

  assert {
    condition     = aws_db_instance.this.db_subnet_group_name == var.db_subnet_group_name
    error_message = "Db subnet group name mismatch"
  }

  assert {
    condition     = aws_db_instance.this.parameter_group_name == var.db_parameter_group_name
    error_message = "Db parameter group name mismatch"
  }

  assert {
    condition     = aws_db_instance.this.db_name == var.db_name
    error_message = "Db name mismatch"
  }

  assert {
    condition     = aws_db_instance.this.username == var.username
    error_message = "Username mismatch"
  }

  assert {
    condition     = aws_db_instance.this.manage_master_user_password == true
    error_message = "Manage master user password mismatch"
  }

  assert {
    condition     = aws_db_instance.this.skip_final_snapshot == var.skip_final_snapshot
    error_message = "Skip final snapshot mismatch"
  }

  assert {
    condition     = aws_db_instance.this.tags == var.tags
    error_message = "Tags mismatch"
  }
}

################################################################################
# DB Subnet Group
################################################################################

run "db_subnet_group_attributes_match" {
  command = plan

  module {
    source = "./modules/rds"
  }

  variables {
    identifier          = "example-identifier"
    instance_class      = "example-instance-class"
    allocated_storage   = 1234
    engine              = "example-engine"
    engine_version      = "example-engine-version"
    vpc_security_group_ids = ["sg-1234567890abcdef"]
    db_name             = "example-db-name"
    username            = "example-username"
    skip_final_snapshot = null

    db_subnet_group_name        = "example-db-subnet-group-name"
    db_subnet_group_description = "example-db-subnet-group-description"
    db_subnet_group_subnet_ids = ["subnet-1234567890abcdef"]
    db_subnet_group_tags = {
      ExampleDb = "SubnetGroupTag"
    }

    db_parameter_group_name   = "example-db-parameter-group-name"
    db_parameter_group_family = "example-db-parameter-group-family"
  }

  assert {
    condition     = aws_db_subnet_group.this.name == var.db_subnet_group_name
    error_message = "Name mismatch"
  }

  assert {
    condition     = aws_db_subnet_group.this.description == var.db_subnet_group_description
    error_message = "Description mismatch"
  }

  assert {
    condition     = aws_db_subnet_group.this.subnet_ids == toset(var.db_subnet_group_subnet_ids)
    error_message = "Subnet ids mismatch"
  }

  assert {
    condition     = aws_db_subnet_group.this.tags == var.db_subnet_group_tags
    error_message = "Tags mismatch"
  }
}

################################################################################
# DB Parameter Group
################################################################################

run "db_parameter_group_attributes_match" {
  command = plan

  module {
    source = "./modules/rds"
  }

  variables {
    identifier          = "example-identifier"
    instance_class      = "example-instance-class"
    allocated_storage   = 1234
    engine              = "example-engine"
    engine_version      = "example-engine-version"
    vpc_security_group_ids = ["sg-1234567890abcdef"]
    db_name             = "example-db-name"
    username            = "example-username"
    skip_final_snapshot = null

    db_subnet_group_name = "example-db-subnet-group-name"
    db_subnet_group_subnet_ids = ["subnet-1234567890abcdef"]

    db_parameter_group_name        = "example-db-parameter-group-name"
    db_parameter_group_description = "example-db-parameter-group-description"
    db_parameter_group_family      = "example-db-parameter-group-family"
    db_parameter_group_parameters = [
      {
        name         = "example-param"
        value        = "example-param-value"
        apply_method = "pending-reboot"
      }
    ]
    db_parameter_group_tags = {
      ExampleDb = "ParameterGroupTag"
    }
  }

  assert {
    condition     = aws_db_parameter_group.this.name == var.db_parameter_group_name
    error_message = "Name mismatch"
  }

  assert {
    condition     = aws_db_parameter_group.this.description == var.db_parameter_group_description
    error_message = "Description mismatch"
  }

  assert {
    condition     = aws_db_parameter_group.this.family == var.db_parameter_group_family
    error_message = "Family mismatch"
  }

  assert {
    condition     = length(aws_db_parameter_group.this.parameter) == 1
    error_message = "Parameter count mismatch"
  }

  assert {
    condition     = tolist(aws_db_parameter_group.this.parameter)[0] == var.db_parameter_group_parameters[0]
    error_message = "Parameter mismatch"
  }

  assert {
    condition     = aws_db_parameter_group.this.tags == var.db_parameter_group_tags
    error_message = "Tags mismatch"
  }
}
