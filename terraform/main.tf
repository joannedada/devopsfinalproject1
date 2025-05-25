provider "aws" {
  region = "us-east-1"
}

# VPC with 2 public subnets
resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = "us-east-1${count.index == 0 ? "a" : "b"}"
}

# S3 bucket for kOps state
resource "aws_s3_bucket" "kops_state" {
  bucket = "jo-kops-state"
}