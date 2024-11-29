variable "ami" {
    type = string
    default = "ami-0453ec754f44f9a4a"

}

variable "instance_type" {
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
    type = string
    default = "keypair"
  
}