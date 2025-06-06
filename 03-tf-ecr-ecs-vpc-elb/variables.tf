# AWS Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

# ECR Repository Names (image URIs for tasks)
variable "flask_ecr_repo" {
  description = "Flask ECR Repository Name"
  type        = string
  default     = "your-repo"
}

variable "express_ecr_repo" {
  description = "Express ECR Repository Name"
  type        = string
  default     = "your-repo"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "CIDR block for subnet 1"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet_2_cidr" {
  description = "CIDR block for subnet 2"
  type        = string
  default     = "10.0.1.0/24"
}

# Security Group Name
variable "security_group_name" {
  description = "Security Group Name"
  type        = string
  default     = "ecs-sg"
}

# ALB Name
variable "alb_name" {
  description = "Application Load Balancer Name"
  type        = string
  default     = "ecs-alb"
}
