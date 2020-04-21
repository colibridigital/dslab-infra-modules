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
    tags = {
      Application = var.tag_application
      Environment = var.tag_environment
      Resource_Debtor = var.tag_resource_deptor
      Resource_CostCenter = var.tag_resource_costcenter
      Resource_Department = var.tag_resource_department
      Resource_Expiration = var.tag_resource_expiration
      Resource_Owner = var.tag_resource_owner
      Resource_Type = var.tag_resource_type
    }
}