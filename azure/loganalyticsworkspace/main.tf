provider "azurerm" {
  version = "=1.38.0"
}

###########################################################
# Log Analytics Workspace
###########################################################
resource "azurerm_log_analytics_workspace" "logs-workspace" {
    name                = var.log_analytics_workspace_name
    location            = var.log_analytics_workspace_location
    resource_group_name = var.dslab_rg_name
    sku                 = var.log_analytics_workspace_sku
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