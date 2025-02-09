variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_availability_zone" {
  type        = string
  description = "AWS Availability Zone"
  default     = "us-east-1a"
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile"
  default     = "default"
}

variable "aws_config_location" {
  type        = string
  description = "AWS Config Location"
  default     = "~/.aws/config"
}

variable "aws_credentials_location" {
  type        = string
  description = "AWS Credentials Location"
  default     = "~/.aws/credentials"
}

variable "aws_instance_name" {
  type        = string
  description = "AWS Instance Name"
  default     = "this"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS Instance Type | Default = t2.micro (Free Tier)"
  default     = "t2.micro"
}

