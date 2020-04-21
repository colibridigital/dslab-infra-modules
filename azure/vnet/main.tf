provider "azurerm" {
  version = "=1.38.0"
}

###########################################################
# VNet Networking
###########################################################
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.rg_location
  resource_group_name = var.rg_name
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

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.subnet_address_prefix
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
  lifecycle {
    ignore_changes = ["route_table_id"]
  }

}