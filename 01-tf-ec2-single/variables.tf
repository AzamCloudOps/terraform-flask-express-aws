variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 20.04"
  type        = string
  default     = "ami-021a584b49225376d" # Ubuntu 20.04 LTS in us-west-2
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "your-key"
} 