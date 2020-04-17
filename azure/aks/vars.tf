###########################################################
# AD
###########################################################
variable aksClusterAppName {
    description = "The cluster application and service principal name"
    type        = string
}
variable aksADServerAppName {
    description = "The server application component AD name for control plane auth"
    type        = string
}
variable aksADClientAppName {
    description = "The client application component AD name for control plane auth"
    type        = string
}

###########################################################
# Log analytics
###########################################################
variable logs_workspace_id {
    description = "The Logs Workspace ID"
    type        = string
}

###########################################################
# Subnet
###########################################################
variable subnet_id {
    description = "The subnet ID"
    type        = string
}


###########################################################
# RG
###########################################################
variable dslab_rg_name {
    description = "The resource group name"
    type        = string
}

###########################################################
# Key Vault
###########################################################
variable dslabKeyvaultName {
    description = "The Azure Key Vault Name"
    type        = string
}
variable dslabKeyvaultRg {
    description = "The Resource Group of the Azure Key Vault"
    type        = string
}

###########################################################
# AKS
###########################################################
variable aks_dslab_version {
    description = "The version of the AKS"
    type        = string
}
variable aks_dslab_cluster_name {
    description = "The name of the AKS cluster"
    type        = string
}

#########################
# AKS - Default Node Pool
#########################
variable aks_default_nodepool_node_count {
    description = "Default node pool node count"
    type        = number
}
variable aks_default_nodepool_vm_size {
    description = "Default node pool vm type/size"
    type        = string
}
variable aks_default_nodepool_name {
    description = "Default node pool name"
    type        = string
}
variable aks_default_nodepool_os_disk_size_gb {
    description = "Default node pool os disk size"
    type        = number
}
variable aks_default_nodepool_type {
    description = "Default node pool type"
    type        = string
}
variable aks_default_nodepool_enable_autoscaling {
   description = "Default node pool autoscaling"
   type        = bool
}
variable aks_default_nodepool_min_count {
   description = "Default node pool minimum count"
   type        = number
}
variable aks_default_nodepool_max_count {
   description = "Default node pool maximum count"
   type        = number
}
#########################
# AKS - Extra Large Node Pool
#########################
variable dslab_large_nodepool_vm_size {
   description = "Large node pool vm size"
   type        = string
}
variable dslab_large_nodepool_name {
   description = "Large node pool name"
   type        = string
}
variable dslab_large_nodepool_os_disk_size_gb {
   description = "Large node pool os disk size in GB"
   type        = number
}
variable dslab_large_nodepool_node_count {
   description = "Large node pool node count"
   type        = number
}
variable dslab_large_nodepool_enable_autoscaling {
   description = "Large node pool autoscaling"
   type        = bool
}
variable dslab_large_nodepool_min_count {
   description = "Large node pool min count"
   type        = number
}
variable dslab_large_nodepool_max_count {
   description = "Large node pool min count"
   type        = number
}

