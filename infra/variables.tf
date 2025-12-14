variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "db_name" {}
variable "db_user" {}
variable "db_password" {
  sensitive = true
}

variable "eks_cluster_name" {
  default = "todo-eks"
}
