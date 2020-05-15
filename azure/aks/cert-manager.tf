data "helm_repository" "jetstack" {
  name = "stable"
  url  = "https://charts.jetstack.io"
}

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "cert-manager"
  namespace  = var.cm_deployment_namespace
  version    = var.cm_deployment_version

  set {
    name  = "installCRDs"
    value = var.cm_deployment_install_crds
  }
}