################################################################################
# IAM Role
################################################################################

variable "name" {
  description = "(Required, Forces new resource) Friendly name of the role."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional, Default:null) Description of the role."
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "(Required) Policy that grants an entity permission to assume the role."
  type        = any
  nullable    = false
}

variable "tags" {
  description = "(Optional, Default:{}) Key-value mapping of tags for the IAM role."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# IAM Policy
################################################################################

variable "iam_policies" {
  description = "(Optional, Default:{}) Map of IAM policies to create and attach to the IAM Role."
  type = map(
    object({
      name        = string
      description = optional(string, null)
      policy = object({
        Version = optional(string, "2012-10-17")
        Statement = list(
          object({
            Sid      = optional(string)
            Effect   = string
            Resource = string
            Action   = optional(list(string), [])
          })
        )
      })
      tags = optional(map(string), {})
    })
  )
  nullable = false
  default  = {}
}

variable "iam_policy_attachments" {
  description = "(Optional, Default:{}) Map of IAM Policy ARNs to attach to the IAM Role."
  type        = map(string)
  nullable    = false
  default     = {}
}
