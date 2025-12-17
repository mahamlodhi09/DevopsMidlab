terraform {
<<<<<<< HEAD
  required_version = ">= 1.3"
=======
  required_version = ">= 1.0"
>>>>>>> 0ab6c93e75e705766a49b85cb754bb65f430f005

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
<<<<<<< HEAD
}
=======
}
>>>>>>> 0ab6c93e75e705766a49b85cb754bb65f430f005
