# for_each terraform code
resource "aws_instance" "foreach" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = "keypair"
    for_each = toset(var.test)
    subnet_id = "subnet-063b9f05cf110d68e"
    tags = {
      Name = each.key
    }

  
}

variable "test" {
    type = list(string)
    default = [ "Thor", "Knull", "Loki"]
  
}