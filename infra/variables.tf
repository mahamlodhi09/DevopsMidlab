variable "aws_region" {
<<<<<<< HEAD
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "cluster_name" {
  default = "exam-eks-cluster"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  sensitive = true
}
=======
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
>>>>>>> 0ab6c93e75e705766a49b85cb754bb65f430f005
