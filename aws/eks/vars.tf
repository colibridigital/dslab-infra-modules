variable "billing_tag" {
  description = "Billing tag"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_version" {
  description = "Kubernetes version to use"
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

variable "eks_cluster_node_group_defaults_disk_size" {
  description = "Cluster node group default disk size"
  type        = number
}

variable "eks_cluster_node_group_defaults_asg_min_size" {
  description = "ASG min size"
  type        = number
}

variable "eks_cluster_node_group_defaults_asg_desired_size" {
  description = "ASG desired size"
  type        = number
}

variable "eks_cluster_node_group_defaults_asg_max_size" {
  description = "ASG max size"
  type        = number
}

variable "eks_cluster_environment_tag_name" {
  description = "Environment tag name"
  type        = string
}

variable "eks_cluster_node_group_medium_instance_type" {
  description = "Medium instance type"
  type        = string
}

variable "eks_cluster_node_group_large_instance_type" {
  description = "Large instance type"
  type        = string
}

variable "eks_cluster_ami_type" {
  description = "AMI type"
  type        = string

}

variable "eks_cluster_config_path" {
  description = "Path to write the config file to"
  type        = string
}


variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}

variable "eks_iam_path" {
  description = "IAM path for policy for autoscaler"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
