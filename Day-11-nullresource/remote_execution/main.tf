resource "aws_instance" "my_ec2" {
    ami = "ami-038bba9a164eb3dc1"
    instance_type = "t2.micro"
    subnet_id = "subnet-074ef43b03ea37795"
    key_name = aws_key_pair.key_name.key_name
    tags = {
      Name = "remote_exe"
    }
}

resource "null_resource" "test_null" {
    provisioner "remote-exec" {
        connection {
          type  = "ssh"
          user = "ec2-user"
          private_key = file("C:/Users/ganes/.ssh/keys/aws_key")
          host = aws_instance.my_ec2.public_ip
        }

        inline = [
         "sudo yum update -y",
         "sudo yum install -y httpd",
         "sudo systemctl start httpd",
         "sudo systemctl enable httpd",
         "touch happy.txt",
         "echo 'Hello, Welcome To Terraform!' >> happy.txt" 

        ]
      
    }
  
}

resource "aws_key_pair" "key_name" {
    key_name = "aws_key"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeUnRxTHwG8jM+Pqc1ibORZ9aEW+dz0KbXCQc6II0Qp ganes@GANESH"
  
}