resource "aws_instance" "name" {
    ami = "ami-0453ec754f44f9a4a"
    instance_type = "t2.micro"
    key_name = "keypair"
    subnet_id = "subnet-02469f8a4cac3142a"
    associate_public_ip_address = true
    user_data = file("test.sh")
    tags = {
      Name = "dev-ec2"
    }
}

output "name" {
  description = "The public IP or DNS of the AWS instance"
  value       = aws_instance.name.public_ip
}
