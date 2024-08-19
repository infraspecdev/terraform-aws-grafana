resource "aws_iam_role" "this" {
  name               = var.name
  description        = var.description
  assume_role_policy = jsonencode(var.assume_role_policy)

  tags = var.tags
}

################################################################################
# IAM Policy
################################################################################

resource "aws_iam_policy" "this" {
  for_each = var.iam_policies

  name        = each.value.name
  description = each.value.description
  policy      = jsonencode(each.value.policy)

  tags = each.value.tags
}

resource "aws_iam_role_policy_attachment" "iam_policies" {
  for_each = aws_iam_policy.this

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.iam_policy_attachments

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
