provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Jenkins-instance" {
  ami           = "ami-0607784b46cbe5816"
  instance_type = "t2.micro"
  key_name = "terraform"
  subnet_id = aws_subnet.Demo-public_subent_01.id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]

 tags = {
    Name = "Jenkins-instance"
  }
}

# creating vpc

resource "aws_vpc" "Demo-vpc" {
    cidr_block = "10.1.0.0/16"
    tags = {
      Name = "Demo-vpc"
    }
  
}

resource "aws_subnet" "Demo-public_subent_01" {
    vpc_id = "${aws_vpc.Demo-vpc.id}"
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
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
