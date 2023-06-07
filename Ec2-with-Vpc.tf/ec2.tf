provider "aws" {
  region = var.location
}

resource "aws_instance" "Jenkins-instance" {
  ami           = var.os-name
  instance_type = var.instance-type
  key_name = var.key-pair
  subnet_id = aws_subnet.Demo-public_subent_01.id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]

 tags = {
    Name = "Jenkins-instance"
  }
}

# creating vpc

resource "aws_vpc" "Demo-vpc" {
    cidr_block = var.vpc-cidr
    tags = {
      Name = "Demo-vpc"
    }
  
}

resource "aws_subnet" "Demo-public_subent_01" {
    vpc_id = "${aws_vpc.Demo-vpc.id}"
    cidr_block = var.subnet1-cidr
    map_public_ip_on_launch = "true"
    availability_zone = var.subent_az
    tags = {
      Name = "Demo-public_subent_01"
    }
  
}

//Creating a Internet Gateway

resource "aws_internet_gateway" "Demo-igw" {
    vpc_id = "${aws_vpc.Demo-vpc.id}"
    tags = {
      Name = "Demo-igw"
    }
}

// Create a route table 

resource "aws_route_table" "Demo-public-rt" {
    vpc_id = "${aws_vpc.Demo-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.Demo-igw.id}"
    }
    tags = {
      Name = "Demo-public-rt"
    }
}

// Associate subnet with routetable 

resource "aws_route_table_association" "Demo-rta-public-subent-1" {
    subnet_id = "${aws_subnet.Demo-public_subent_01.id}"
    route_table_id = "${aws_route_table.Demo-public-rt.id}"
  
}

// create a security group

resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  vpc_id      = aws_vpc.Demo-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}