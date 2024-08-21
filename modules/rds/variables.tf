variable "identifier" {
  description = "(Required) The name of the RDS instance."
  type        = string
  nullable    = false
}

variable "instance_class" {
  description = "(Required) The instance type of the RDS instance."
  type        = string
  nullable    = false
}

variable "storage_type" {
  description = "(Optional, Default:\"gp2\") One of \"standard\", \"gp2\", \"gp3\" or \"io1\"."
  type        = string
  nullable    = false
  default     = "gp2"
}

variable "allocated_storage" {
  description = "(Required) The allocated storage in gibibytes."
  type        = number
  nullable    = false
}

variable "engine" {
  description = "(Optional, Default:null) The database engine."
  type        = string
  default     = null
}

variable "engine_version" {
  description = "(Optional, Default:null) The engine version to use."
  type        = string
  default     = null
}

variable "db_name" {
  description = "(Optional, Default:default_db) The database name."
  type        = string
  nullable    = false
  default     = "default_db"
}

variable "username" {
  description = "(Optional, Default:admin_user) Username for the master DB user."
  type        = string
  nullable    = false
  default     = "admin_user"
}

variable "vpc_security_group_ids" {
  description = "(Optional) List of VPC security groups to associate."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "skip_final_snapshot" {
  description = "(Optional, Default:true) Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
  nullable    = false
  default     = true
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# DB Subnet Group
################################################################################

variable "db_subnet_group_name" {
  description = "(Required, Forces new resource) The name of the DB subnet group."
  type        = string
  nullable    = false
}

variable "db_subnet_group_description" {
  description = "(Optional, Default:\"Managed By Terraform\", Forces new resource) The description of the DB subnet group."
  type        = string
  nullable    = false
  default     = "Managed By Terraform"
}

variable "db_subnet_group_subnet_ids" {
  description = "(Required) A list of VPC subnet IDs."
  type        = list(string)
  nullable    = false
}

variable "db_subnet_group_tags" {
  description = "(Optional, Default:{}) A map of tags to assign to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}

################################################################################
# DB Parameter Group
################################################################################

variable "db_parameter_group_name" {
  description = "(Required, Forces new resource) The name of the DB parameter group."
  type        = string
  nullable    = false
}

variable "db_parameter_group_description" {
  description = "(Optional, Default:\"Managed By Terraform\", Forces new resource) The description of the DB parameter group."
  type        = string
  nullable    = false
  default     = "Managed By Terraform"
}

variable "db_parameter_group_family" {
  description = "(Required, Forces new resource) The family of the DB parameter group."
  type        = string
  nullable    = false
}

variable "db_parameter_group_parameters" {
  description = "(Optional, Default:[]) The DB parameters to apply."
  type = list(
    object({
      name         = string
      value        = string
      apply_method = optional(string)
    })
  )
  nullable = false
  default  = []
}

variable "db_parameter_group_tags" {
  description = "(Optional, Default:{}) A map of tags to assign to the resource."
  type        = map(string)
  nullable    = false
  default     = {}
}
