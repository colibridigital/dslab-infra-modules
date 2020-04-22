resource "aws_iam_role_policy_attachment" "workers_autoscaling" {
  policy_arn = aws_iam_policy.worker_autoscaling.arn
  role       = module.eks.worker_iam_role_name
}

resource "aws_iam_policy" "worker_autoscaling" {
  name_prefix = "eks-worker-autoscaling-${module.eks.cluster_id}"
  description = "EKS worker node autoscaling policy for cluster ${module.eks.cluster_id}"
  policy      = data.aws_iam_policy_document.worker_autoscaling.json
  path        = var.eks_iam_path
}

data "aws_iam_policy_document" "worker_autoscaling" {
  statement {
    sid    = "eksWorkerAutoscalingAll"
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "eksWorkerAutoscalingOwn"
    effect = "Allow"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${module.eks.cluster_id}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
  }
}

provider helm {
  kubernetes {
    config_path = var.eks_cluster_config_path
  }
}


data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}


resource "helm_release" "eks_worker_autoscaler" {
  name       = "eks-autoscaler"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "cluster-autoscaler"
  #namespace  = var.dslab_namespace
  #timeout = 300 # default
  #wait = true '# default

  set {
    name  = "autoDiscovery.clusterName"
    value = module.eks.cluster_id
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }
}
