###########################################################
# Subnet
###########################################################
variable subnet_name {
    description = "Name of the Subnet"
    type        = string
}

variable subnet_address_prefix {
    description = "Subnet address prefix"
    type        = string
}

###########################################################
# Vnet
###########################################################
variable vnet_name {
    description = "Name of the VPC"
    type        = string
}

variable vnet_address_space {
    description = "VNet address space"
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