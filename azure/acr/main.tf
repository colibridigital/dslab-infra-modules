provider "azurerm" {
  version = "=1.38.0"
}

###########################################################
# Resource Group
###########################################################
data "azurerm_resource_group" "rg" {
  name = var.dslab_rg_name
}

###########################################################
# ACR Registries
###########################################################
resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  sku                      = var.acr_sku
  admin_enabled            = true
  tags = {
    Application = "DSLab"
    Environment = "poc"
    Resource_Debtor = "2132"
  }
}