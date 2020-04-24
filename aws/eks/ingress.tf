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