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

#create new workspace -- terraform workspace new dev
#list workspace -- terraform workspace list
#Switch worksapce -- terraform workspace select dev
#terraform plan -var-file=dev.tfvars
#terraform plan -var-file=test.tfvars