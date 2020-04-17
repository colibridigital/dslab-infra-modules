provider "azurerm" {
  version = "=1.38.0"
}

provider "random" {
  version = "~> 2.1"
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}


data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

###########################################################
# Resource Group
###########################################################
data "azurerm_resource_group" "rg" {
  name = var.dslab_rg_name
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
data "azurerm_key_vault" "dslab-keyvault" {
  name                = var.dslabKeyvaultName 
  resource_group_name = var.dslabKeyvaultRg 
}

# Get Secrets from Key Vault
data "azurerm_key_vault_secret" "aksClusterSpiSecret" {
  name         = var.aksClusterAppName
  key_vault_id = data.azurerm_key_vault.dslab-keyvault.id
}

data "azurerm_key_vault_secret" "aks_ad_server_app_client_secret" {
  name         = var.aksADServerAppName
  key_vault_id = data.azurerm_key_vault.dslab-keyvault.id
}

# Create AKS cluster
resource "azurerm_kubernetes_cluster" "aks_dslab" {
  name                = var.aks_dslab_cluster_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.aks_dslab_cluster_name
  kubernetes_version  = var.aks_dslab_version

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
      tenant_id     =  data.azurerm_client_config.current.tenant_id
      server_app_id = data.azuread_application.aksADServerApp.application_id
      server_app_secret =data.azurerm_key_vault_secret.aks_ad_server_app_client_secret.value
      client_app_id = data.azuread_application.aksADClientApp.application_id
    }
  }

  addon_profile {
      oms_agent {
        enabled                    = true
        log_analytics_workspace_id = var.logs_workspace_id
        }
    }

  tags = {
      Application = "DSLab"
      Environment = "poc"
      Resource_Debtor = "2132"
      Resource_CostCenter = "CC_2002552"
      Resource_Department = "TCI-I"
      Resource_Expiration = "2020.06.30"
      Resource_Owner      = "Koeppel Gaudenz"
      Resource_Type       = "ApplicationShared"
  }
}

###########################################################
# Additional Node Pools - DSLAB -Large
###########################################################
resource "azurerm_kubernetes_cluster_node_pool" "dslab_large_nodepool" {
  name                  = var.dslab_large_nodepool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_dslab.id
  vm_size               = var.dslab_large_nodepool_vm_size
  os_disk_size_gb       = var.dslab_large_nodepool_os_disk_size_gb
  node_count            = var.dslab_large_nodepool_node_count
  vnet_subnet_id        = var.subnet_id
  enable_auto_scaling   = var.dslab_large_nodepool_enable_autoscaling
  min_count             = var.dslab_large_nodepool_min_count
  max_count             = var.dslab_large_nodepool_max_count
}