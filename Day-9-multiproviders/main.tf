#Region us-west-1 ec2_instance and vpc
resource "aws_instance" "ec2_1" {
    ami = "ami-038bba9a164eb3dc1"
    instance_type = "t2.micro"
    key_name = "marvel"
    tags = {
      Name = "Avengers_1"
    }
  
}

resource "aws_vpc" "vpc_1" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Loki"
    }
  
}



#Region us-west-2 ec2_instance and vpc
resource "aws_instance" "ec2_2" {
    ami = "ami-055e3d4f0bbeb5878"
    instance_type = "t2.micro"
    key_name = "oregon"
    provider = aws.oregon
    tags = {
      Name = "Avengers_2"
    }
  
}


resource "aws_vpc" "vpc_2" {
    cidr_block = "10.0.0.0/16"
    provider = aws.oregon
    tags = {
      Name = "Ultron"
    }
  
}
