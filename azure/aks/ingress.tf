provider helm {
  kubernetes {
    host                   = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
    client_key             = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_key)}"
    client_certificate     = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)}"
    cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)}"
  }
}


data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "nginx-ingress"
  namespace  = var.ingress_deployment_namespace

  set {
    name  = "controller.name"
    value = "nginx-ingress"
  }

  set {
    name  = "controller.scope.namespace"
    value = var.ingress_deployment_namespace
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