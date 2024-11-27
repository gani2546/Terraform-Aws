
# terraform import aws_instance.test_ec2 i-026a6fdaf4520e86c
resource "aws_instance" "test_ec2" {
    ami = "ami-0453ec754f44f9a4a"
    instance_type = "t2.micro"
    key_name = "keypair"
    tags = {
      Name = "my_ec2"
    }

  
}

# terraform import aws_s3_bucket.test_s3 myawss3buckettf
resource "aws_s3_bucket" "test_s3" {
    bucket = "myawss3buckettf"
}