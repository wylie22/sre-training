variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "bucket_name" {
  description = "Bucket name for Loki storage"
  type    = string
}

variable "cluster_name" {
  description = "Name of EKS cluster"
  type = string
}

variable "namespace" {
  description = "Namespace of Loki installation"
  type        = string
}

variable "cluster_iam" {
  description = "IAM Role of EKS cluster"
  type = string
}

variable "serviceaccount" {
  description = "Service account of Loki installation"
  type        = string
  default     = "loki"
}

variable "node_role" {
    description = "Worker Node Group Role"
    type        = string
}