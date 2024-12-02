locals {
  ami = "ami-038bba9a164eb3dc1"
  instance_type = "t2.micro"
  key_name = "marvel"
}

resource "aws_instance" "ec2" {
    ami = local.ami
    instance_type = local.instance_type
    key_name = local.key_name
    tags = {
      Name = "Local_ec2"
    }

  
}