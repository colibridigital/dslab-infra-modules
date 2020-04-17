###########################################################
# ECR Registries
###########################################################
module dslab-deployment-ecr {
  source           = "JamesWoolfenden/ecr/aws"
  version          = "0.2.21"
  name             = var.ecr_deployment_name
  repositorypolicy = data.aws_iam_policy_document.allowlocals.json
  common_tags = {
    billing = var.billing_tag
  }
}

module dslab-jupyter-base-ecr {
  source           = "JamesWoolfenden/ecr/aws"
  version          = "0.2.21"
  name             = var.ecr_base_name
  repositorypolicy = data.aws_iam_policy_document.allowlocals.json
  common_tags = {
    billing = var.billing_tag
  }
}

module dslab-jupyter-ecr {
  source           = "JamesWoolfenden/ecr/aws"
  version          = "0.2.21"
  name             = var.ecr_jupyter_name
  repositorypolicy = data.aws_iam_policy_document.allowlocals.json
  common_tags = {
    billing = var.billing_tag
  }
}

module dslab-jupyter-gpu-ecr {
  source           = "JamesWoolfenden/ecr/aws"
  version          = "0.2.21"
  name             = var.ecr_jupyter_gpu_name
  repositorypolicy = data.aws_iam_policy_document.allowlocals.json
  common_tags = {
    billing = var.billing_tag
  }
}