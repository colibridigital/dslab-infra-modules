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


resource "helm_release" "dslab_autoscaler" {
  name       = "dslab-autoscaler"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "cluster-autoscaler"
  #namespace  = var.dslab_namespace
  #timeout = 300 # default
  #wait = true '# default

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_id
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }
}



data "helm_repository" "jupyterhub" {
  name = "jupyterhub"
  url  = "https://jupyterhub.github.io/helm-chart/"
}


resource "helm_release" "dslab_jupyterhub" {
  name          = "jupyterhub"
  repository    = data.helm_repository.jupyterhub.metadata[0].name
  chart         = "jupyterhub"
  namespace     = var.dslab_namespace
  timeout       = 36000
  version       = "v0.8.2"
  recreate_pods = "true"
  #wait = true '# default

  values = [
    "${file(var.dslab_jupyter_config)}"
  ]

  set_sensitive {
    name  = "hub.cookieSecret"
    value = var.dslab_hub_cookie_secret
  }

  set {
    name  = "hub.db.url"
    value = var.dslab_hub_db_url
  }

  set_sensitive {
    name  = "proxy.secretToken"
    value = var.dslab_proxy_secret_token
  }

  set {
    name  = "auth.custom.config.client_id"
    value = var.dslab_azure_ad_application_client_id
  }

  set_sensitive {
    name  = "auth.custom.config.client_secret"
    value = var.dslab_azure_ad_application_client_secret
  }

  set {
    name  = "auth.custom.config.tenant_id"
    value = var.dslab_azure_tennant
  }
}

# resource "helm_release" "my_cache" {
#   name       = "my-cache"
#   repository = data.helm_repository.incubator.metadata[0].name
#   chart      = "redis-cache"
# }


