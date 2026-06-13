# =============================================================
# VPC — Your private network in AWS
# Think of a VPC as your own isolated data center in the cloud.
# Everything you build (EC2, RDS, etc.) lives inside it.
# =============================================================

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"   # IP range for your entire VPC (65,536 addresses)
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name      = "tflearn-vpc"
    ManagedBy = "Terraform"
  }
}

# =============================================================
# SUBNETS
# A subnet is a smaller slice of the VPC's IP range.
# Public subnet  → has a route to the internet (for EC2, ALB)
# Private subnet → no direct internet route (for RDS, internal apps)
# =============================================================

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id          # reference the VPC we just created above
  cidr_block              = "10.0.1.0/24"            # 256 addresses within the VPC range
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true                     # EC2 instances here get a public IP automatically

  tags = {
    Name = "tflearn-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "tflearn-private-subnet"
  }
}

# =============================================================
# INTERNET GATEWAY (IGW)
# The door between your VPC and the public internet.
# Without this, nothing inside the VPC can reach the internet.
# =============================================================

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tflearn-igw"
  }
}

# =============================================================
# ROUTE TABLE
# Rules that tell traffic where to go.
# "For traffic going to 0.0.0.0/0 (internet) → use the IGW"
# =============================================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                        # all internet-bound traffic
    gateway_id = aws_internet_gateway.main.id        # goes through the IGW
  }

  tags = {
    Name = "tflearn-public-rt"
  }
}

# Associate the route table with the public subnet
# Without this association, the subnet doesn't know to use this route table.
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
