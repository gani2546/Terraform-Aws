resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"
    count = length(var.test_vpc)
    tags = {
     # Name = "dev-vpc"
      Name = "vpc-${count.index}"
      Name = var.test_vpc[count.index]
    }
  
}

variable "test_vpc" {
    type = list(string)
    default = [ "Wall-E" , "Sonic" ]
  
}