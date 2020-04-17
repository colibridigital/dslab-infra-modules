
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

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "efs-share-name" {
  description = "EFS share name"
  type        = string
}
