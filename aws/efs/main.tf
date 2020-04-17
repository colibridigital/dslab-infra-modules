
###########################################################
# EFS File Share
###########################################################
module "efs" {
  source                = "cloudposse/efs/aws"
  version               = "0.14.0"
  region                = var.aws_region
  security_groups       = var.allowed_security_groups
  subnets               = var.private_subnets
  vpc_id                = var.vpc_id
  encrypted             = true
  name                  = var.efs-share-name
  performance_mode      = "generalPurpose"

  tags = {
    billing = var.billing_tag
  }
}