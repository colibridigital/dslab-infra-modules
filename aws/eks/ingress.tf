provider helm {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "nginx-ingress"

  set {
    name  = "controller.name"
    value = "nginx-ingress"
  }

  set {
    name  = "controller.scope.namespace"
    value = var.dslab_namespace
  }

  set {
    name  = "controller.autoscaling.enabled"
    value = "true"
  }

  set {
    name  = "controller.autoscaling.minReplicas"
    value = 3
  }

  set {
    name  = "controller.minReadySeconds"
    value = 10
  }

  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
}