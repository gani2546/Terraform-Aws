terraform {
backend "s3" {
    bucket = "terraforms3awsbucket"
    key = "terraform.tfstate" 
    region = "us-east-1"
    encrypt  = true 
}
}