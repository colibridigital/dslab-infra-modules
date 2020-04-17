data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source                        = "terraform-aws-modules/eks/aws"
  version                       = "11.0.0"
  cluster_name                  = var.eks_cluster_name
  cluster_version               = var.eks_cluster_version
  subnets                       = var.private_subnets
  vpc_id                        = var.vpc_id
  manage_aws_auth               = true
  write_kubeconfig              = true
  
  node_groups_defaults = {
    ami_type                          = var.eks_cluster_ami_type
    disk_size                         = var.eks_cluster_node_group_defaults_disk_size
    subnets                           = [var.private_subnets[0]]
    desired_capacity                  = var.eks_cluster_node_group_defaults_asg_desired_size
    max_capacity                      = var.eks_cluster_node_group_defaults_asg_max_size
    min_capacity                      = var.eks_cluster_node_group_defaults_asg_min_size

    additional_tags = {
      Environment                                               = var.eks_cluster_environment_tag_name
      billing                                                   = var.billing_tag
      "k8s.io/cluster-autoscaler/enabled"                       = true
      "kubernetes.io/cluster-autoscaler/${var.eks_cluster_name}"  = "owned"
    }
  }

  node_groups = {
    large = {
      instance_type = var.eks_cluster_node_group_large_instance_type
      k8s_labels = {
        Environment = var.eks_cluster_environment_tag_name
        podaffinity = "jupyter-large"
      }
    }

    medium = {
      instance_type = var.eks_cluster_node_group_medium_instance_type
      k8s_labels = {
        Environment = var.eks_cluster_environment_tag_name
        podaffinity = "jupyter-medium"
      }   
    }
  }

  tags = {
    billing = var.billing_tag
  }

  map_users = var.map_users
}