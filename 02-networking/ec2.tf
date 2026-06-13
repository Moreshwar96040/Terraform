# =============================================================
# DATA SOURCE — Fetch the latest Amazon Linux 2 AMI automatically
# Instead of hardcoding an AMI ID (which changes by region),
# we ask AWS for the current one at runtime.
# =============================================================

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# =============================================================
# EC2 INSTANCE — A virtual machine in your public subnet
# =============================================================

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2.id   # from the data source above
  instance_type          = "t2.micro"                       # free tier eligible
  subnet_id              = aws_subnet.public.id             # place it in the public subnet
  vpc_security_group_ids = [aws_security_group.web_sg.id]  # attach the security group

  # user_data runs as a shell script when the instance first boots
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from Terraform Phase 2!</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name      = "tflearn-web-server"
    ManagedBy = "Terraform"
  }
}
