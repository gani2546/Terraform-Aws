resource "aws_instance" "test_ec2" {
    ami = "ami-038bba9a164eb3dc1"
    instance_type = "t2.micro"
    tags = {
      Name = "my_ec2_null"
    }
  
}

resource "null_resource" "test_null" {

    triggers = {
      id = aws_instance.test_ec2.id
    }
    
    provisioner "local-exec" {
        command = "echo Hello World"
        interpreter = ["C:/Program Files/Git/bin/bash.exe", "-c"]
      
    }
  
}