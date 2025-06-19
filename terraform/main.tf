provider "aws" {
  region = var.aws_region
}

#resource "aws_key_pair" "key-pair" {
#  key_name   = var.key_pair_name
#  public_key = file(var.public_key_path)
#}

resource "aws_security_group" "app-security-group" {
  name        = "app-security-group-v2"
  description = "Allow SSH, HTTP, frontend/backend ports"

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

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 3001
    to_port     = 3001
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

resource "aws_instance" "bdg_docker_host" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "key-pair"
  vpc_security_group_ids = [aws_security_group.app-security-group.id]

  tags = {
    Name = "bdg-docker-instance"
  }
}

data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["app-security-group"]
  }
}

terraform {
  backend "s3" {
    bucket = "bdg-terraform-state-gh-2198" 
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock-v2"
    encrypt = true
  }
}

