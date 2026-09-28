provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "app_sg" {
  name        = "terraform-ansible-sg-v3"
  description = "Allow SSH and App Port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                         = "ami-01a00762f46d584a1"
  instance_type               = "t3.micro"
  key_name                    = "Ansible_Assignment"
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = true
}

output "instance_ip" {
  value = aws_instance.app_server.public_ip
}

