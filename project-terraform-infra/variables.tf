variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.22.0.0/16"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}
variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}
variable "addons" {
  description = "Kubernetes addons"
  type        = any
  default = {
    enable_aws_load_balancer_controller = true
    enable_metrics_server               = true
  }
}

#variable "ami" {
#    type = string
#    default = "ami-07a6e3b1c102cdba8"
#}
#variable "instance_type" {
#    type = string
#    default = "c5.large"
#}



# Addons Git
variable "gitops_addons_org" {
  description = "Git repository org/user contains for addons"
  type        = string
  default     = "https://github.com/aws-samples"
}
variable "gitops_addons_repo" {
  description = "Git repository contains for addons"
  type        = string
  default     = "eks-blueprints-add-ons"
}
variable "gitops_addons_revision" {
  description = "Git repository revision/branch/ref for addons"
  type        = string
  default     = "main"
}
variable "gitops_addons_basepath" {
  description = "Git repository base path for addons"
  type        = string
  default     = "argocd/"
}
variable "gitops_addons_path" {
  description = "Git repository path for addons"
  type        = string
  default     = "bootstrap/control-plane/addons"
}

# Workloads Git
variable "gitops_workload_org" {
  description = "Git repository org/user contains for workload"
  type        = string
  default     = "https://github.com/aws-ia"
}
variable "gitops_workload_repo" {
  description = "Git repository contains for workload"
  type        = string
  default     = "terraform-aws-eks-blueprints"
}
variable "gitops_workload_revision" {
  description = "Git repository revision/branch/ref for workload"
  type        = string
  default     = "main"
}
variable "gitops_workload_basepath" {
  description = "Git repository base path for workload"
  type        = string
  default     = "patterns/gitops/"
}
variable "gitops_workload_path" {
  description = "Git repository path for workload"
  type        = string
  default     = "getting-started-argocd/k8s"
}

variable "enable_gitops_auto_addons" {
  description = "Automatically deploy addons"
  type        = bool
  default     = false
}

variable "enable_gitops_auto_workloads" {
  description = "Automatically deploy addons"
  type        = bool
  default     = false
}