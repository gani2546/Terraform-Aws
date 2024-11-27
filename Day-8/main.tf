resource "aws_instance" "name" {
    ami = "ami-0453ec754f44f9a4a"
    instance_type = var.instance_type
    key_name = "keypair"
    subnet_id = "subnet-02469f8a4cac3142a"
    tags = {
      Name = local.instance_name
    }
}

locals {
  instance_name = "${terraform.workspace}-instace"
}