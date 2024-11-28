# Count function
resource "aws_instance" "count" {
    ami = "ami-0453ec754f44f9a4a"
    instance_type = "t2.micro"
    key_name = "keypair"
    #count = 3
    count = length(var.test)
    subnet_id = "subnet-063b9f05cf110d68e"
    tags = {
     # Name = "test_ec2"
     # Name = "Web_ec2-${count.index}"
       Name = var.test[count.index]
    }
  
} 

variable "test" {
  type    = list(string)
  default = ["Ironman", "Thanos", "Spiderman"]
} 
