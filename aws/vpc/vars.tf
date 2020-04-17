variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "billing_tag" {
  description = "Billing tag"
  type        = string
}

variable "eks_cluster_name_prefix" {
  description = "Prefix for name of the EKS cluster"
  type        = string
}

variable "private_subnets" {
  description = "private subnets"
  type        = list
}

variable "public_subnets" {
  description = "public subnets"
  type        = list
}

variable "cidr" {
  description = "cidr"
  type        = string
}



