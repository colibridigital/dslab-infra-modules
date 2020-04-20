###########################################################
# ACR
###########################################################
variable acr_name {
    description = "The ACR name"
    type        = string
}

variable acr_sku {
     description = "The ACR SKU name"
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
