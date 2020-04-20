variable "eks_cluster_config_path" {
  description = "Path to the k8s config file"
  type        = string
}

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

variable "dslab_jupyter_config" {
  description = "Path to the jupyter yaml file"
  type        = string
}

variable "dslab_hub_cookie_secret" {
  description = "The hub cookie secret"
  type        = string
}

variable "dslab_hub_db_url" {
  description = "The hub db url"
  type        = string
}

variable "dslab_proxy_secret_token" {
  description = "Proxy secret token"
  type        = string
}

variable "dslab_azure_ad_application_client_id" {
  description = "Azure application client id"
  type        = string
}


variable "dslab_azure_ad_application_client_secret" {
  description = "Azure application client secret"
  type        = string
}

variable "dslab_azure_tennant" {
  description = "Azure tennant id"
  type        = string
}





