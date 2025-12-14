resource "aws_db_subnet_group" "main" {
  name       = "todo-db-subnet-group"
  subnet_ids = aws_subnet.public[*].id
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot  = true
  publicly_accessible  = false
  tags = { Name = "todo-rds" }
}
