variable "ecr_deployment_name" {
  description = "Deployment name"
  type        = string
}

variable "ecr_base_name" {
  description = "Jupyter base name"
  type        = string
}

variable "ecr_jupyter_name" {
  description = "Jupyter name"
  type        = string
}

variable "ecr_jupyter_gpu_name" {
  description = "Jupyter GPU name"
  type        = string
}

variable "billing_tag" {
  description = "Billing tag"
  type        = string
}
