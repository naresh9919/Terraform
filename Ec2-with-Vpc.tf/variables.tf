variable "location" {
    default = "ap-south-1"
}

variable "os-name" {
    default = "ami-0607784b46cbe5816"
}

variable "key-pair" {
    default = "terraform"
}

variable "instance-type" {
    default = "t2.small"
}

variable "vpc-cidr" {
    default = "10.10.0.0/16"  
}

variable "subnet1-cidr" {
    default = "10.10.1.0/24"
  
}
variable "subent_az" {
    default =  "ap-south-1a"  
}