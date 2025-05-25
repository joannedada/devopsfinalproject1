provider "aws" {
  region = var.aws_region
}

# VPC with 2 public subnets
resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
}

# EC2 instances for control plane and workers
resource "aws_instance" "control_plane" {
  ami           = "ami-0953476d60561c955" 
  instance_type = "t2.micro"
  key_name      = "jonewkeypair"
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "k8s-control"
  }
}

resource "aws_instance" "workers" {
  count         = 2
  ami           = "ami-0953476d60561c955"
  instance_type = "t2.micro"
  key_name      = "jonewkeypair"
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "k8s-worker-${count.index + 1}"
  }
}

# S3 bucket for kOps state
resource "aws_s3_bucket" "kops_state" {
  bucket = "jo-kops-state"
}