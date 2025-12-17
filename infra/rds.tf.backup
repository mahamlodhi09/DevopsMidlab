resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t3.micro"

  db_name              = "examdb"
  username             = var.db_username
  password             = var.db_password

  skip_final_snapshot  = true
  publicly_accessible  = true
}
