provider "azurerm" {
  version = "=1.38.0"
}

###########################################################
# ACR Registries
###########################################################
resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.dslab_rg_name
  location                 = var.dslab_rg_location
  sku                      = var.acr_sku
  admin_enabled            = true
  tags = {
    Application = "DSLab"
    Environment = "poc"
    Resource_Debtor = "2132"
  }
}