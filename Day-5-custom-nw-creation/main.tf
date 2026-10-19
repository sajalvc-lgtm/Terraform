# 1. VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block= "10.0.0.0/16"
  
  tags = {
      name= "custom_vpc"
  }
}


# 2. Private Subnet
resource "aws_subnet" "custom_private_subnet"{
  cidr_block ="10.0.0.0/24"
  vpc_id = aws_vpc.custom_vpc.id
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  
  tags ={
    name= "custom_private_subnet"
  }
}
# 3. Public Subnet
resource "aws_subnet" "custom_public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "custom-public-subnet"
  }
}

# 4. Internet Gateway
resource "aws_internet_gateway"  "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    name= "custom_igw"
  }
}

# 5. Public Route Table
resource "aws_route_table" "custom_public_rt" {
  vpc_id= aws_vpc.custom_vpc.id

  route {
    cidr_block ="0.0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }
  
   tags = {
    Name = "custom-public-route-table"
  }
}

# 6. Associate Public Route Table with Public Subnet
resource "aws_route_table_association"  "public_assoc"{
  subnet_id= aws_subnet.custom_public_subnet.id
  route_table_id= aws_route_table.custom_public_rt.id
}

# 7. Elastic IP for NAT Gateway
resource "aws_eip" "custom_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "custom-nat-eip"
  }
}

# 8. NAT Gateway in Public Subnet
resource "aws_nat_gateway" "custom_nat" {
  allocation_id = aws_eip.custom_nat_eip.id
  subnet_id     = aws_subnet.custom_public_subnet.id

  tags = {
    Name = "custom-nat-gateway"
  }

  depends_on = [
    aws_internet_gateway.custom_igw,
	  aws_route_table_association.public_assoc
  ]
}

# 9. Private Route Table
resource "aws_route_table" "custom_private_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "custom-private-route-table"
  }
}

# 10. Private Route to NAT Gateway
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.custom_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.custom_nat.id
}

# 11. Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.custom_private_subnet.id
  route_table_id = aws_route_table.custom_private_rt.id
}

# 12. Security Group
resource "aws_security_group"  "custom_sg" {
  name = "custom_sg"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    description = "Allow HTTP" 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
}

  tags = {
    Name = "custom-sg"
  }
}

# 13. EC2 Instance in Public Subnet
resource "aws_instance" "custom_instance" {
  ami                         = "ami-097855b862d5b1eb2"
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1b"
  subnet_id                   = aws_subnet.custom_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.custom_sg.id]
  key_name                    = "sajal-key"
  associate_public_ip_address = true

  tags = {
    Name = "custom-instance"
  }
}