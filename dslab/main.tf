provider "kubernetes" {
  load_config_file       = true
  config_path = var.eks_cluster_config_path
  version                = "~> 1.10"
}


resource "kubernetes_namespace" "dslab" {
  metadata {
    name = var.dslab_namespace
  }
}