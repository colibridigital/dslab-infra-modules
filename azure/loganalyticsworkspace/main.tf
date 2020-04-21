provider "azurerm" {
  version = "=1.38.0"
}

###########################################################
# Log Analytics Workspace
###########################################################
resource "azurerm_log_analytics_workspace" "logs-workspace" {
    name                = var.log_analytics_workspace_name
    location            = var.log_analytics_workspace_location
    resource_group_name = var.rg_name
    sku                 = var.log_analytics_workspace_sku
    tags                = var.tags
}