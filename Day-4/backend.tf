terraform {
backend "s3" {
    bucket = "terraformawss3bucket"
    key = "terraform.tfstate" 
    region = "eu-north-1"
    encrypt  = true 
}
}