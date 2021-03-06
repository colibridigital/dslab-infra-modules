###########################################################
# AD
###########################################################
variable tenant_id {
    description = "The Azure Tenant Id"
    type        = string
}

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
variable log_workspace_id {
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
variable rg_name {
    description = "The resource group name"
    type        = string
}

variable rg_location {
    description = "The resource group location"
    type        = string
}

###########################################################
# Key Vault
###########################################################
variable keyvaultName {
    description = "The Azure Key Vault Name"
    type        = string
}
variable keyvaultRg {
    description = "The Resource Group of the Azure Key Vault"
    type        = string
}

###########################################################
# AKS
###########################################################
variable aks_version {
    description = "The version of the AKS"
    type        = string
}
variable aks_cluster_name {
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
variable aks_large_nodepool_vm_size {
   description = "Large node pool vm size"
   type        = string
}
variable aks_large_nodepool_name {
   description = "Large node pool name"
   type        = string
}
variable aks_large_nodepool_os_disk_size_gb {
   description = "Large node pool os disk size in GB"
   type        = number
}
variable aks_large_nodepool_node_count {
   description = "Large node pool node count"
   type        = number
}
variable aks_large_nodepool_enable_autoscaling {
   description = "Large node pool autoscaling"
   type        = bool
}
variable aks_large_nodepool_min_count {
   description = "Large node pool min count"
   type        = number
}
variable aks_large_nodepool_max_count {
   description = "Large node pool min count"
   type        = number
}

variable tags {
  description = "The tags to be applied in each resource"  
  type        =  map
}

#########################
# AKS - Ingress Controller
#########################
variable "ingress_deployment_namespace" {
  description = "Namespace to deploy Nginx to"
  type        = string
}

#########################
# AKS - Cert Manager
#########################
variable "cm_deployment_namespace" {
  description = "Namespace to deploy Cert Manager to"
  type        = string
}

variable "cm_deployment_version" {
  description = "Cert Manager helm release version"
  type        = string
}

variable "cm_deployment_install_crds" {
  description = "Boolean if to install cert manager custom CRDs"
  type        = bool
}


