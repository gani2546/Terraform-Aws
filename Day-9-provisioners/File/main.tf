resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Thor"
    }
  
}

resource "aws_subnet" "test" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.test.id
    map_public_ip_on_launch = true
    tags = {
      Name = "loki"
    }
  
}

resource "aws_internet_gateway" "my_ig" {
    vpc_id = aws_vpc.test.id
    tags = {
        Name = "Groot"
    }
  
}

resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.test.id
    tags = {
      Name = "Tony"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_ig.id

    }
  
}

resource "aws_route_table_association" "test" {
    subnet_id = aws_subnet.test.id
    route_table_id = aws_route_table.my_rt.id
  
}

resource "aws_security_group" "name" {
    vpc_id = aws_vpc.test.id
    tags = {
      Name = "Tom"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 88
        to_port = 88
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_instance" "server" {
    ami = "ami-038bba9a164eb3dc1"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.test.id
    vpc_security_group_ids = [aws_security_group.name.id]
    key_name = aws_key_pair.my_key.key_name
    
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = file("C:/Users/ganes/.ssh/keys/aws_key")
    }

    provisioner "file" {   
        source      = "file.txt"
        destination = "/home/ec2-user/file.txt"
    }

    tags = {
      Name = "Marvel"
    }
}

resource "aws_key_pair" "my_key" {
    key_name = "aws_key"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeUnRxTHwG8jM+Pqc1ibORZ9aEW+dz0KbXCQc6II0Qp ganes@GANESH"
  
}