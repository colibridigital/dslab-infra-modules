###########################################################
# Log analytics
###########################################################
variable log_analytics_workspace_name {
    description = "The log analytics workspace name"
    type        = string
}

variable log_analytics_workspace_location {
    description = "The log analytics workspace location"
    type        = string
}

variable log_analytics_workspace_sku {
    description = "The log analytics workspace sku"
    type        = string
}


###########################################################
# RG
###########################################################
variable rg_name {
    description = "The resource group name"
    type        = string
}

variable rg_location {
    description = "The resource group location"
    type        = string
}

variable tags {
  description = "The tags to be applied in each resource"  
  type        =  map
}