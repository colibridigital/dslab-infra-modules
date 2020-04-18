provider "kubernetes" {
  load_config_file = true
  config_path      = var.eks_cluster_config_path
  version          = "~> 1.10"
}

resource "kubernetes_namespace" "dslab" {
  metadata {
    name = var.dslab_namespace
  }
}

resource "kubernetes_persistent_volume_claim" "dslab_pvc" {
  metadata {
    name = "efs-pvc"
    annotations = {
      "volume.beta.kubernetes.io/storage-class" : "aws-efs"
    }
    namespace = var.dslab_namespace
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.dslab_pvc_resource_requests
      }
    }
  }

  depends_on = [kubernetes_namespace.dslab]
}
