variable "aws_region" {
  description = "The AWS region to deploy into"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile"
  default     = "default"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "SSH key pair name for EC2 access"
  type        = string
}

variable "app_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}
