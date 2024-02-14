# AWS VPC resource
resource "aws_vpc" "database_main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-tf-database"
  }
}

# AWS Internet Gateway resource
resource "aws_internet_gateway" "gw_database_tf" {
  vpc_id = aws_vpc.database_main.id # Reference to the VPC

  tags = {
    Name = "internet-gateway-database-tf"
  }
}

# AWS Subnet resource
resource "aws_subnet" "database_main" {
  for_each          = var.database_subnets
  vpc_id            = aws_vpc.database_main.id # Reference to the VPC
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag_name
  }
}

# AWS Route Table resource
resource "aws_route_table" "rt_database" {
  vpc_id = aws_vpc.database_main.id # Reference to the VPC

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_database_tf.id
  }

  tags = {
    Name = "route-table-database-tf"
  }
}

# AWS Route Table Association resource
resource "aws_route_table_association" "rta_database" {
  for_each       = aws_subnet.database_main
  subnet_id      = aws_subnet.database_main[each.key].id    # Reference to the subnet
  route_table_id = aws_route_table.rt_database.id # Reference to the route table
}

# Output block for subnets IDs
output "subnet_database_ids" {
  value = [for subnet in aws_subnet.database_main : subnet.id]
}

# AWS RDS DB subnet group resource
resource "aws_db_subnet_group" "database_main" {
  name       = "subnet-group-${var.env}-${var.random_uuid}-tf"
  subnet_ids = [for subnet in aws_subnet.database_main : subnet.id] # List of subnet IDs belonging to the subnet group
}

# AWS Security Group resource for allowing TLS inbound traffic and all outbound traffic
resource "aws_security_group" "allow_database_port" {
  name        = "allow-database-port-tf"
  description = "Allow Database all inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.database_main.id

  tags = {
    Name = "vpc-database-port-tf"
  }
}

# Ingress rule for allowing TLS inbound traffic
resource "aws_vpc_security_group_ingress_rule" "allow_database_port" {
  security_group_id = aws_security_group.allow_database_port.id # Reference to the security group
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

# Egress rule for allowing all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_database_port" {
  security_group_id = aws_security_group.allow_database_port.id # Reference to the security group
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# AWS RDS database instance resource
resource "aws_db_instance" "default" {
  identifier           = "${var.aws_db_instance_name}-${var.env}-${var.random_uuid}-tf"
  allocated_storage    = 20
  db_name              = "bixtech${var.env}"
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "postgres"
  skip_final_snapshot  = true
  publicly_accessible  = true # Whether the instance is publicly accessible
  db_subnet_group_name = aws_db_subnet_group.database_main.id
  vpc_security_group_ids = [aws_security_group.allow_database_port.id]
}

# Output block for AWS RDS database instance endpoint
output "aws_db_instance_endpoint" {
  value = aws_db_instance.default.endpoint # Value set to the endpoint of the default database instance
}

# Output block for AWS RDS database instance port
output "aws_db_instance_port" {
  value = aws_db_instance.default.port # Value set to the port of the default database instance
}