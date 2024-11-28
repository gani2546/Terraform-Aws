resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"
    for_each = toset(var.foreach)
    tags = {
      Name = each.key
    }
    
}

variable "foreach" {
    type = list(string)
    default = ["Bay Max", "Mufasa", "Simba" ]
  
}