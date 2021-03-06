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