terraform {
  ## Assumes s3 bucket and dynamo DB table already set up
  ## See /code/03-basics/aws-backend
  backend "s3" {
    bucket         = "terraformstate-bucket-aminundakun" # REPLACE WITH YOUR BUCKET NAME
    key            = "terraform-state-file/project-modules/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "development-instance" {
  ami           = "ami-0e83be366243f524a"  # Replace with your desired AMI ID
  instance_type = "t2.micro"               # Replace with your desired instance type
  key_name      = "Sonar-key"          # Replace with your key pair name
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

  tags = {
    Name = "development-instance"
  }
}

resource "aws_security_group" "development-instance_security_group" {
  name        = "development-instance-security-group"
  description = "Allow inbound traffic on ports 80 (HTTP) and 22 (SSH)"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP. For production, restrict as needed.
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP. For production, restrict as needed.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}