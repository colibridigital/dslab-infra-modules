variable "eks_cluster_config_path" {
  description = "Path to the k8s config file"
  type        = string
}

variable "dslab_namespace" {
  description = "The K8s namespace to use"
  type        = string
}
