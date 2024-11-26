
#Create a VPC
resource "aws_vpc" "local_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF_VPC"
    }
  
}

#create public subnet
resource "aws_subnet" "public" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.local_vpc.id
    tags = {
      Name = "Public_Subnet"
    }
  
}

#Create private subnet
resource "aws_subnet" "private" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.local_vpc.id
    tags = {
      Name = "Private_Subnet"
    }
  
}

#Create Internet gateway
resource "aws_internet_gateway" "local_ig" {
    vpc_id = aws_vpc.local_vpc.id
    tags = {
      Name = "TF_IG"
    }
  
}

#Allocate an Elastic IP
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "NAT_EIP"
  }
} 

#Create NAT gateway
resource "aws_nat_gateway" "local_nat" {
  connectivity_type = "public"
  allocation_id = aws_eip.nat_eip.id
  subnet_id         = aws_subnet.private.id
  tags = {
    Name = "TF_NAT"
  }
}

#create Public Route Table
resource "aws_route_table" "local_pub_rt" {
    vpc_id = aws_vpc.local_vpc.id
    tags = {
      Name = "PUB_RT"
    }

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.local_ig.id
  }

}

#Public Subnet Association
resource "aws_route_table_association" "local" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.local_pub_rt.id
}

#Create Private Route Table
resource "aws_route_table" "local_prv_rt" {
    vpc_id = aws_vpc.local_vpc.id
    tags = {
      Name = "PRV_RT"
    }

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.local_nat.id
    }
}

#Private Subnet Association
resource "aws_route_table_association" "psa" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.local_prv_rt.id
  
}


#Create a security group
resource "aws_security_group" "local_sg" {
    vpc_id = aws_vpc.local_vpc.id
    tags = {
      Name = "TF_SG"
    }

    # Inbound Rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Outbound Rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
  
}

#create Public EC2 Instance
resource "aws_instance" "public_ec2" {
  ami = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id 
  vpc_security_group_ids = [aws_security_group.local_sg.id]
  key_name = "keypair"
  associate_public_ip_address = true
  tags = {
    Name = "TF_Pub_Ec2"
  }
}

#Create Private Ec2 Instance
resource "aws_instance" "private_ec2" {
    ami = "ami-0453ec754f44f9a4a"
    instance_type =  "t2.micro"
    subnet_id = aws_subnet.private.id
    vpc_security_group_ids = [ aws_security_group.local_sg.id ]
    key_name = "keypair"
    tags = {
      Name = "TF_Prv_Ec2"
    }
  
}


