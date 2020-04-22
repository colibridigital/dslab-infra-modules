provider "kubernetes" {
  load_config_file = true
  config_path      = var.eks_cluster_config_path
  version          = "~> 1.10"
}

provider "helm" {
  kubernetes {
    config_path = var.eks_cluster_config_path
  }
}

resource "kubernetes_namespace" "dslab" {
  metadata {
    name = var.dslab_namespace
  }
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "dslab_efs_provisioner" {
  name       = "dslab-efs-provisioner"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "efs-provisioner"
  #namespace  = var.dslab_namespace
  #timeout = 300 # default
  #wait = true '# default

  set {
    name  = "efsProvisioner.efsFileSystemId"
    value = var.dslab_efs_mount_id
  }

  set {
    name  = "efsProvisioner.awsRegion"
    value = var.aws_region
  }
}

resource "kubernetes_persistent_volume_claim" "dslab_pvc" {
  metadata {
    name = var.dslab_pvc_name
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

  depends_on = [kubernetes_namespace.dslab, helm_release.dslab_efs_provisioner]
}
########################################################

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_id
}

########################################################

data "helm_repository" "jupyterhub" {
  name = "jupyterhub"
  url  = "https://jupyterhub.github.io/helm-chart/"
}

# resource "helm_release" "my_cache" {
#   name       = "my-cache"
#   repository = data.helm_repository.incubator.metadata[0].name
#   chart      = "redis-cache"
# }


