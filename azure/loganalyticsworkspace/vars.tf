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
variable dslab_rg_name {
    description = "The resource group name"
    type        = string
}

variable dslab_rg_location {
    description = "The resource group location"
    type        = string
}