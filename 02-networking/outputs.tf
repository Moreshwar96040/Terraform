# =============================================================
# OUTPUTS — Print useful values after `terraform apply`
# Like return values from a function. Helps you find your
# resources without logging into the AWS Console.
# =============================================================

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "ec2_public_ip" {
  description = "Public IP of the web server — paste in browser to see the page"
  value       = aws_instance.web.public_ip
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}
