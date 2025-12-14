module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.28"
  subnets         = aws_subnet.public[*].id
  vpc_id          = aws_vpc.main.id

  node_groups = {
    todo_nodes = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }

  tags = {
    Environment = "dev"
    Project     = "todoapp"
  }
}
