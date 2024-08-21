provider "aws" {
  region = "ap-south-1"
}

################################################################################
# IAM Role
################################################################################

run "iam_role_attributes_match" {
  command = plan

  module {
    source = "./modules/iam-role"
  }

  variables {
    name        = "example-name"
    description = "example-description"
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = "ExampleAssumeRole"
          Principal = {
            Service = "service.amazonaws.com"
          }
        }
      ]
    }

    tags = {
      Example = "Tag"
    }
  }

  assert {
    condition     = aws_iam_role.this.name == var.name
    error_message = "Name mismatch"
  }

  assert {
    condition     = aws_iam_role.this.description == var.description
    error_message = "Description mismatch"
  }

  assert {
    condition     = aws_iam_role.this.assume_role_policy == jsonencode(var.assume_role_policy)
    error_message = "Assume role policy mismatch"
  }

  assert {
    condition     = aws_iam_role.this.tags == var.tags
    error_message = "Tags mismatch"
  }
}

################################################################################
# IAM Policy
################################################################################

run "does_not_create_iam_policy_check" {
  command = plan

  module {
    source = "./modules/iam-role"
  }

  variables {
    name = "example-name"
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = "ExampleAssumeRole"
          Principal = {
            Service = "service.amazonaws.com"
          }
        }
      ]
    }

    iam_policies = {}
  }

  assert {
    condition     = length(aws_iam_policy.this) == 0
    error_message = "IAM policy was created"
  }
}

run "iam_policy_attributes_match" {
  command = plan

  module {
    source = "./modules/iam-role"
  }

  variables {
    name = "example-name"
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = "ExampleAssumeRole"
          Principal = {
            Service = "service.amazonaws.com"
          }
        }
      ]
    }

    iam_policies = {
      example-policy = {
        name        = "example-policy-name"
        description = "example-policy-description"
        policy = {
          Version = "2012-10-17"
          Statement = []
        }

        tags = {
          ExamplePolicy = "Tag"
        }
      }
    }
  }

  assert {
    condition     = length(aws_iam_policy.this) == 1
    error_message = "IAM policy was not created"
  }

  assert {
    condition     = aws_iam_policy.this["example-policy"].name == var.iam_policies["example-policy"].name
    error_message = "Name mismatch"
  }

  assert {
    condition     = aws_iam_policy.this["example-policy"].description == var.iam_policies["example-policy"].description
    error_message = "Description mismatch"
  }

  assert {
    condition     = aws_iam_policy.this["example-policy"].policy == jsonencode(var.iam_policies["example-policy"].policy)
    error_message = "Policy mismatch"
  }

  assert {
    condition     = aws_iam_policy.this["example-policy"].tags == var.iam_policies["example-policy"].tags
    error_message = "Tags mismatch"
  }
}

################################################################################
# IAM Role Policy Attachment
################################################################################

run "does_not_create_iam_role_policy_attachment__iam_policies__check" {
  command = plan

  module {
    source = "./modules/iam-role"
  }

  variables {
    name = "example-name"
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = "ExampleAssumeRole"
          Principal = {
            Service = "service.amazonaws.com"
          }
        }
      ]
    }

    iam_policies = {}
  }

  assert {
    condition     = length(aws_iam_role_policy_attachment.iam_policies) == 0
    error_message = "IAM role policy attachment was created"
  }
}

run "iam_role_policy_attachment__iam_policies__attributes_check" {
  command = plan

  module {
    source = "./modules/iam-role"
  }

  variables {
    name = "example-name"
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = "ExampleAssumeRole"
          Principal = {
            Service = "service.amazonaws.com"
          }
        }
      ]
    }

    iam_policies = {
      example-policy = {
        name        = "example-policy-name"
        description = "example-policy-description"
        policy = {
          Version = "2012-10-17"
          Statement = []
        }

        tags = {
          ExamplePolicy = "Tag"
        }
      }
    }
  }

  assert {
    condition     = length(aws_iam_role_policy_attachment.iam_policies) == 1
    error_message = "IAM role policy attachment was not created"
  }

  assert {
    condition     = aws_iam_role_policy_attachment.iam_policies["example-policy"].role == aws_iam_role.this.name
    error_message = "Role mismatch"
  }
}

run "does_not_create_iam_role_policy_attachment_check" {
  command = plan

  module {
    source = "./modules/iam-role"
  }

  variables {
    name = "example-name"
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = "ExampleAssumeRole"
          Principal = {
            Service = "service.amazonaws.com"
          }
        }
      ]
    }

    iam_policy_attachments = {}
  }

  assert {
    condition     = length(aws_iam_role_policy_attachment.this) == 0
    error_message = "IAM role policy attachment was created"
  }
}

run "iam_role_policy_attachment_attributes_check" {
  command = plan

  module {
    source = "./modules/iam-role"
  }

  variables {
    name = "example-name"
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = "ExampleAssumeRole"
          Principal = {
            Service = "service.amazonaws.com"
          }
        }
      ]
    }

    iam_policy_attachments = {
      ExamplePolicy = "arn:aws:iam::aws:policy/ExamplePolicy"
    }
  }

  assert {
    condition     = length(aws_iam_role_policy_attachment.this) == 1
    error_message = "IAM role policy attachment was not created"
  }

  assert {
    condition     = aws_iam_role_policy_attachment.this["ExamplePolicy"].role == aws_iam_role.this.name
    error_message = "Role mismatch"
  }
}
