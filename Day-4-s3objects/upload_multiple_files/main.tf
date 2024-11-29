resource "aws_s3_bucket" "name" {
    bucket = "myawss3bucket2546"
  
}

resource "aws_s3_object" "name" {
    bucket = aws_s3_bucket.name.id
    key = each.key
    for_each = local.files
    source = each.value 
    acl = "private"
  
}

locals {
  type = "application/pdf"
  files ={
    "Ganesh.pdf" = "C:/Resume/Ganesh.pdf"
    "GitTest.pdf" = "C:/Resume/GitTest.pdf"
  }

}