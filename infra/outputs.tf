output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_1_id" {
  description = "Public Subnet 1 ID"
  value       = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  description = "Public Subnet 2 ID"
  value       = aws_subnet.public_2.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.app_sg.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.app_server.id
}

output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.app_server.public_ip
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.app_storage.id
}