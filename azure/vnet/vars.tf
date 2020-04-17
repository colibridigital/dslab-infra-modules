###########################################################
# Subnet
###########################################################
variable dslab_subnet_name {
    description = "Name of the Subnet"
    type        = string
}

variable dslab_subnet_address_prefix {
    description = "Subnet address prefix"
    type        = string
}

###########################################################
# Vnet
###########################################################
variable dslab_vnet_name {
    description = "Name of the VPC"
    type        = string
}

variable dslab_vnet_address_space {
    description = "VNet address space"
    type        = string
}

###########################################################
# RG
###########################################################
variable dslab_rg_name {
    description = "The resource group name"
    type        = string
}