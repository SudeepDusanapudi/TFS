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