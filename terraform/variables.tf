variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  default     = "prod-cluster"
}

variable "availability_zones" {
  description = "AZs for HA deployment"
  default     = ["us-east-1a", "us-east-1b"]
}