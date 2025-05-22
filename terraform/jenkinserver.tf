provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "jenkins_docker_server" {
  ami           = "ami-0953476d60561c955" 
  instance_type = "t2.medium"
  key_name      = "jonewkeypair"     

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install -y docker
              sudo systemctl start docker
              sudo usermod -aG docker ec2-user
              sudo dnf install -y jenkins
              sudo systemctl start jenkins
              EOF

  tags = {
    Name = "Jenkins-Docker-Server"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-docker-sg"
  description = "Allow SSH, Jenkins, and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For future web apps
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}