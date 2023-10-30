#vpc
resource "aws_vpc" "ecomm" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ecomm-vpc"
  }
}

#public_subnet
resource "aws_subnet" "ecomm_public_sn" {
  vpc_id     = aws_vpc.ecomm.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "ecomm_public_subnet"
  }
}


#private_subnet
resource "aws_subnet" "ecomm_private_sn" {
  vpc_id     = aws_vpc.ecomm.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "ecomm_private_subnet"
  }
}

#internetgateway
resource "aws_internet_gateway" "ecomm_Igw" {
  vpc_id = aws_vpc.ecomm.id

  tags = {
    Name = "ecomm_internetgateway"
  }
}

#public_routetables

resource "aws_route_table" "ecomm_Public_route" {
  vpc_id = aws_vpc.ecomm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecomm_Igw.id
  }

  tags = {
    Name = "ecommpublicroute"
  }
}

#publicroutetableassociation

resource "aws_route_table_association" "ecomm_public_association" {
  subnet_id      = aws_subnet.ecomm_public_sn.id
  route_table_id = aws_route_table.ecomm_Public_route.id
}

#private_routetables
resource "aws_route_table" "ecomm_Private_route" {
  vpc_id = aws_vpc.ecomm.id

  tags = {
    Name = "ecommprivateroute"
  }
}

#privateroutetableassociation
resource "aws_route_table_association" "ecomm_private_association" {
  subnet_id      = aws_subnet.ecomm_private_sn.id
  route_table_id = aws_route_table.ecomm_Private_route.id
}

#public Nacl

resource "aws_network_acl" "ecomm_public_nacl" {
  vpc_id = aws_vpc.ecomm.id
  subnet_ids = [aws_subnet.ecomm_public_sn.id]

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "ecommpublic_Nacl"
  }
}

#private Nacl

resource "aws_network_acl" "ecomm_private_nacl" {
  vpc_id = aws_vpc.ecomm.id
  subnet_ids = [aws_subnet.ecomm_private_sn.id]

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "ecommprivate_Nacl"
  }
}