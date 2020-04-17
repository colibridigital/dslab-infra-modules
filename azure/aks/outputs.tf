output "azure_kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_dslab.id
}

output "current_subscription_id" {
  value = data.azurerm_subscription.current.id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks_dslab.id
}
