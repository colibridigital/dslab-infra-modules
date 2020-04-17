output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "worker_security_group_id" {
  description = "Security group ids attached to the workers."
  value       = module.eks.worker_security_group_id
}

output "vpc_0_cluster_security_group_id" {
  description = "Security group id of the first vpc."
  value       = data.aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}


output "kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.eks.config_map_aws_auth
}

output "cluster_id" {
  description = "EKS Cluster name"
  value       = module.eks.cluster_id
}
