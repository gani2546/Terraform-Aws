provider "aws" {
    region = "us-west-1"
  
}

provider "aws" {
    region = "us-west-2"
    alias = "oregon"  
}