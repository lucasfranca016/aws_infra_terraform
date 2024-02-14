# AWS VPC resource
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-tf"
  }
}

# AWS Subnet resource
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id # Reference to the VPC
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-tf"
  }
}

# AWS Internet Gateway resource
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id # Reference to the VPC

  tags = {
    Name = "internet-gateway-tf"
  }
}

# AWS Route Table resource
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id # Reference to the VPC

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route-table-tf"
  }
}

# AWS Route Table Association resource
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.main.id             # Reference to the subnet
  route_table_id = aws_route_table.route_table.id # Reference to the route table
}

# AWS Security Group resource for allowing TLS inbound traffic and all outbound traffic
resource "aws_security_group" "allow_tls" {
  name        = "allow-tls-tf"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow-tls-tf"
  }
}

# Ingress rule for allowing TLS inbound traffic
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id # Reference to the security group
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Egress rule for allowing all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id # Reference to the security group
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Output block for subnet ID
output "subnet_id" {
  value = aws_subnet.main.id # Value set to the ID of the main subnet
}

# Output block for security group ID
output "security_group_id" {
  value = aws_security_group.allow_tls.id # Value set to the ID of the security group allowing TLS
}


