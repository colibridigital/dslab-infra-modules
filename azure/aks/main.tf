provider "azurerm" {
  version = "=1.38.0"
}

###########################################################
# AKS Cluster
###########################################################

# Get AD components
data "azuread_application" "aksClusterSpi" {
  name = var.aksClusterAppName
}

data "azuread_application" "aksADServerApp" {
  name = var.aksADServerAppName
}

data "azuread_application" "aksADClientApp" {
  name = var.aksADClientAppName
}

# Get Key Vault
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvaultName 
  resource_group_name = var.keyvaultRg 
}

# Get Secrets from Key Vault
data "azurerm_key_vault_secret" "aksClusterSpiSecret" {
  name         = var.aksClusterAppName
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "aks_ad_server_app_client_secret" {
  name         = var.aksADServerAppName
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# Create AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = var.aks_cluster_name
  kubernetes_version  = var.aks_version

  default_node_pool {
    name                = var.aks_default_nodepool_name
    node_count          = var.aks_default_nodepool_node_count
    vm_size             = var.aks_default_nodepool_vm_size
    vnet_subnet_id      = var.subnet_id
    type                = var.aks_default_nodepool_type
    os_disk_size_gb     = var.aks_default_nodepool_os_disk_size_gb
    enable_auto_scaling = var.aks_default_nodepool_enable_autoscaling
    min_count           = var.aks_default_nodepool_min_count
    max_count           = var.aks_default_nodepool_max_count
  }

  service_principal {
    client_id     = data.azuread_application.aksClusterSpi.application_id
    client_secret = data.azurerm_key_vault_secret.aksClusterSpiSecret.value
  }

  role_based_access_control {
    enabled = true

    azure_active_directory   {
      tenant_id     =  var.tenant_id
      server_app_id = data.azuread_application.aksADServerApp.application_id
      server_app_secret =data.azurerm_key_vault_secret.aks_ad_server_app_client_secret.value
      client_app_id = data.azuread_application.aksADClientApp.application_id
    }
  }

  addon_profile {
      oms_agent {
        enabled                    = true
        log_analytics_workspace_id = var.log_workspace_id
        }
    }

  tags = var.tags
}

###########################################################
# Additional Node Pools - DSLAB -Large
###########################################################
resource "azurerm_kubernetes_cluster_node_pool" "aks_large_nodepool" {
  name                  = var.aks_large_nodepool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.aks_large_nodepool_vm_size
  os_disk_size_gb       = var.aks_large_nodepool_os_disk_size_gb
  node_count            = var.aks_large_nodepool_node_count
  vnet_subnet_id        = var.subnet_id
  enable_auto_scaling   = var.aks_large_nodepool_enable_autoscaling
  min_count             = var.aks_large_nodepool_min_count
  max_count             = var.aks_large_nodepool_max_count
}