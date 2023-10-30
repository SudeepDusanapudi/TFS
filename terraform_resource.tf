resource "aws_ebs_volume" "Terraform_vpc" {
  availability_zone = "us-east-2a"
  size              = 4

  tags = {
    Name = "EBS_Volume"
  }
}