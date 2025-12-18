resource "aws_db_subnet_group" "postgres" {
  name       = "devops-midlab-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "devops-midlab-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "devops-midlab-rds-sg"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust for security; allow from EKS nodes
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-midlab-rds-sg"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t3.micro"

  db_name              = "examdb"
  username             = var.db_username
  password             = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot  = true
  publicly_accessible  = false  # Changed to false since it's in private subnets
}
