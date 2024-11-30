resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Wolverine"
    }
  
}

resource "aws_subnet" "test" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.test.id
    map_public_ip_on_launch = true
    tags = {
      Name = "Deadpool"
    }
  
}

resource "aws_internet_gateway" "my_ig" {
    vpc_id = aws_vpc.test.id
    tags = {
        Name = "Professor_X"
    }
  
}

resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.test.id
    tags = {
      Name = "Beast"
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
      Name = "Mystique"
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
   # key_name = aws_key_pair.my_key.key_name

    provisioner "local-exec" {
        command = "echo ${aws_instance.server.public_ip} >> public_ip.txt"
        interpreter = ["C:/Program Files/Git/bin/bash.exe", "-c"]

    }
    tags = {
      Name = "X-Men"
    }
}
