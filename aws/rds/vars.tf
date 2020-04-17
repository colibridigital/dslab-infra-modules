variable "billing_tag" {
  description = "Billing tag"
  type        = string
}

variable "private_subnets" {
  description = "The private subnets"
  type        = list
}

variable "vpc_id" {
  description = "The VPC id"
  type        = string
}

variable "allowed_security_groups" {
  description = "Security groups that are allowed access"
  type        = list
}

variable "rds_user_db_name" {
  description = "database module name"
  type        = string
}

variable "rds_user_db_default_db_name" {
  description = "database name"
  type        = string
}

variable "rds_user_db_default_username" {
  description = "database user name"
  type        = string
}

variable "rds_user_db_default_password" {
  description = "The default password"
  type        = string
}

variable "rds_user_db_min_capacity" {
  description = "Database min capacity"
  type        = number
}

variable "rds_user_db_max_capacity" {
  description = "Database max capacity"
  type        = number
}

variable "rds_user_db_seconds_until_pause" {
  description = "Database seconds until pause"
  type        = number
}
