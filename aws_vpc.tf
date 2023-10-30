#vpc
resource "aws_vpc" "ecomm" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ecomm-vpc"
  }
}
