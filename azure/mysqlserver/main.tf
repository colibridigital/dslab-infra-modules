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

###########################################################
# Key Vault
###########################################################

# Get Key Vault
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvaultName 
  resource_group_name = var.keyvaultRg 
}

# Get secret
data "azurerm_key_vault_secret" "azure_mysql_admin_pass" {
  name         = var.dslab_mysql_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

###########################################################
# Azure MySQL User Database
###########################################################

resource "azurerm_mysql_server" "dslab_mysql" {
  name                = var.dslab_mysql_name
  location            = var.dslab_rg_location
  resource_group_name = var.dslab_rg_name

  sku {
    name     = var.dslab_mysql_sku_name
    capacity = var.dslab_mysql_sku_capacity
    tier     = var.dslab_mysql_sku_tier
    family   = var.dslab_mysql_sku_family
  }

  storage_profile {
    storage_mb            = var.dslab_mysql_sp_storage_mb
    backup_retention_days = var.dslab_mysql_sp_backup_retention_days
    geo_redundant_backup  = var.dslab_mysql_sp_geo_redundant_backup
  }

  administrator_login          = var.azure_mysql_admin_user
  administrator_login_password = data.azurerm_key_vault_secret.azure_mysql_admin_pass.value
  version                      = var.dslab_mysql_version
  ssl_enforcement              = var.dslab_mysql_ssl_enforcement
  
  tags = {
    Application = "DSLab"
    Environment = "poc"
    Resource_Debtor = "2132"
  }
}

###########################################################
# Azure MySQL VNet Rule
###########################################################
resource "azurerm_mysql_virtual_network_rule" "dslab_mysql_vnetrule" {
  name                = var.dslab_mysql_vnet_rule_name
  resource_group_name = var.rg_name
  server_name         = azurerm_mysql_server.dslab_mysql.name
  subnet_id           = var.subnet_id
}