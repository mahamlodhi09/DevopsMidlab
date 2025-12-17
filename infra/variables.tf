variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "devops-midlab-cluster"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "devops-midlab"
}