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

variable "subnet2-cidr" {
    default = "10.10.2.0/24"
  
}

variable "subnet3-cidr" {
    default = "10.10.3.0/24"
  
}

variable "subnet4-cidr" {
    default = "10.10.4.0/24"
  
}

variable "subnet5-cidr" {
    default = "10.10.5.0/24"
  
}

variable "subnet6-cidr" {
    default = "10.10.6.0/24"
  
}
variable "subent_az1" {
    default =  "ap-south-1a"  
}

variable "subent_az2" {
    default =  "ap-south-1a"  
}

variable "subent_az3" {
    default =  "ap-south-1a"  
}

variable "subent_az4" {
    default =  "ap-south-1b"  
}

variable "subent_az5" {
    default =  "ap-south-1b"  
}

variable "subent_az6" {
    default =  "ap-south-1b"  
}
