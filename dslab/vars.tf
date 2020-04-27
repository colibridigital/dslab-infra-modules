variable "eks_cluster_id" {
  description = "Id of the EKS cluster"
  type        = string
}

variable "dslab_namespace" {
  description = "The K8s namespace to use"
  type        = string
}

variable "dslab_pvc_resource_requests" {
  description = "The resource requests required by the pvc"
  type        = string
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "dslab_efs_mount_id" {
  description = "The efs mount point"
  type        = string
}

variable "dslab_pvc_name" {
  description = "The name of the persistence volume claim"
  type        = string

}

variable "dslab_autoscaling_iam_policy_path" {
  description = "IAM path for the autoscaling policy"
  type = string
  
}
