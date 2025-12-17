variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "devopsmidlab"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = "devops-key"  # You'll need to create this in AWS
}