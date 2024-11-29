resource "aws_s3_bucket" "my_s3" {
    bucket = "myawss3tfbucket"
  
}

resource "aws_s3_object" "name" {
    bucket = aws_s3_bucket.my_s3.id
    key = "AWSInterviewGuide.pdf"
    source = "C:/Aws/AWSInterviewGuide.pdf"
    acl = "private"
  
}