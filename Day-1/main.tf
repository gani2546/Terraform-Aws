resource "aws_instance" "name" {
    ami = "ami-05edb7c94b324f73c"
    instance_type = "t2.micro"
    key_name = "ec2key"
    tags = {
      Name = "My_Ec2"
    }
  
}