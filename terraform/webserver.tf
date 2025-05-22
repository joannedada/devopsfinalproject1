provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0953476d60561c955"
  instance_type = "t2.micro"
  key_name      = "jonewkeypair"
  tags = { Name = "Web-Server" }
}