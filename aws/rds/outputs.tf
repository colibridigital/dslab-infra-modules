
output "database_endpoint" {
  description = "RDS Database Endpoint"
  value       = module.aurora.this_rds_cluster_endpoint
}

output "database_sg_id" {
  description = "RDS Database Security Group ID"
  value       = module.aurora.this_security_group_id
}