provider "aws" {
  
}

resource "aws_instance" "name" {
    ami = "ami-0453ec754f44f9a4a"
    instance_type = "t2.micro"
    key_name = "keypair"
    subnet_id = "subnet-02469f8a4cac3142a"
    tags = {
      Name = "test_ec2"
    }
}

resource "aws_s3_bucket" "name" {
    bucket = "mys3terraformawsbucket"
  
}