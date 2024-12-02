# Condition block for ec2_instance
 variable "create_instance" {
    type = bool
    default = false
  
}
resource "aws_instance" "test_ec2" {
    ami = "ami-038bba9a164eb3dc1"
    instance_type = "t2.micro"
    subnet_id = "subnet-00192991e1e4a6aa1"
    count = var.create_instance ? 1 : 0
    tags = {
      Name = "condition_block"
    }
  
}

#Condition block for S3_bucket
resource "aws_s3_bucket" "test_s3" {
    bucket = "mys3conditionbucket"
    count = var.S3_bucket ? 1 : 0

}

variable "S3_bucket" {
    type = bool
    default = true
  
}



