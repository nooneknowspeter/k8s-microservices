variable "aws_instance_name" {
  type        = string
  description = "AWS Instance Name"
  default     = "this"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS Instance Type | Default = t2.medium, Min 2 CPU Cores)"
  default     = "t2.medium"
}

variable "aws_ami" {
  type        = string
  description = "AWS AMI | Default = Amazon Linux 2023 AMI (Free Tier)"
  default     = "ami-088b41ffb0933423f"
}

variable "aws_user_data" {
  type        = string
  description = "AWS EC2 Commands To Run On Instance Launch"
  default     = "echo hello"
}
