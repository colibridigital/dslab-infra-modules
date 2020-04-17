
###########################################################
# RDS User Database
###########################################################
resource "aws_db_parameter_group" "aurora_db_56_parameter_group" {
  name        = "aurora-db-56-parameter-group"
  family      = "aurora5.6"
}

resource "aws_rds_cluster_parameter_group" "aurora_56_cluster_parameter_group" {
  name        = "test-aurora-56-cluster-parameter-group"
  family      = "aurora5.6"
}


module "aurora" {
  name                                = var.rds_user_db_name
  source                              = "terraform-aws-modules/rds-aurora/aws"
  version                             = "2.11.0"
  engine                              = "aurora"
  engine_version                      = "5.6.10a"
  subnets                             = var.private_subnets
  vpc_id                              = var.vpc_id
  publicly_accessible                 = false
  engine_mode                         = "serverless"
  replica_scale_enabled               = false
  replica_count                       = 0
  backtrack_window                    = 10 # ignored in serverless
  instance_type                       = "db.r4.large"
  apply_immediately                   = true
  skip_final_snapshot                 = true
  storage_encrypted                   = true
  db_parameter_group_name             = aws_db_parameter_group.aurora_db_56_parameter_group.id
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.aurora_56_cluster_parameter_group.id
  iam_database_authentication_enabled = false
  allowed_security_groups             = var.allowed_security_groups 
  database_name                       = var.rds_user_db_default_db_name
  create_security_group               = true
  username                            = var.rds_user_db_default_username
  password                            = var.rds_user_db_default_password

  scaling_configuration = {
    auto_pause               = true
    max_capacity             = var.rds_user_db_max_capacity
    min_capacity             = var.rds_user_db_min_capacity
    seconds_until_auto_pause = var.rds_user_db_seconds_until_pause
    timeout_action           = "ForceApplyCapacityChange"
  }

  tags = {
    billing = var.billing_tag
  }
}