# =============================================================
# SECURITY GROUP — Virtual firewall for your EC2 instance
# Controls what traffic is ALLOWED in (ingress) and out (egress).
# Default AWS behavior: deny all inbound, allow all outbound.
# =============================================================

resource "aws_security_group" "web_sg" {
  name        = "tflearn-web-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  # INGRESS = inbound rules (traffic coming INTO your EC2)
  ingress {
    description = "SSH from anywhere (restrict to your IP in real projects)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # WARNING: open to all; for learning only
  }

  ingress {
    description = "HTTP web traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # EGRESS = outbound rules (traffic going OUT from your EC2)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"             # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tflearn-web-sg"
  }
}
