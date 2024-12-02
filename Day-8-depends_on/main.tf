# --------------case-1------------- 
resource "aws_instance" "my_ec2" {
    ami = "ami-038bba9a164eb3dc1"
    instance_type = "t2.micro"
    key_name = "marvel"
    depends_on = [ aws_s3_bucket.my_s3]
    tags = {
      Name = "Depends_on"
    }
    
}


resource "aws_s3_bucket" "my_s3" {
    bucket = "awss3bucketdependson"
  
} 



# ------------case-2--------------
resource "aws_instance" "my_ec2" {
    ami = "ami-038bba9a164eb3dc1"
    instance_type = "t2.micro"
    key_name = "marvel"
    tags = {
      Name = "Depends_on"
    }
    
}

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    depends_on = [ aws_instance.my_ec2 ]
    tags = {
      Nmae = "depends_vpc"
    }
  
}


resource "aws_s3_bucket" "my_s3" {
    bucket = "awss3bucketdependson"
    depends_on = [ aws_instance.my_ec2 , aws_vpc.my_vpc]
  
}


