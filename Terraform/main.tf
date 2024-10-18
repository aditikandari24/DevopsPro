provider "aws" {
  region = var.region
}

resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.instance_type

  security_groups = [aws_security_group.web_security_group.name]

  tags = {
    Name = "MyWebServer"
  }
}

# Security group for allowing traffic
resource "aws_security_group" "web_security_group" {
  name = "web_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH from anywhere
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP frontend
  }

  ingress {
    from_port   = 3500
    to_port     = 3500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Backend access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
