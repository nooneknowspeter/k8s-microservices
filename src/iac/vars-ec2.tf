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

variable "aws_ami" {
  type        = string
  description = "AWS AMI | Default = Ubuntu 24.04 LTS (Free Tier)"
  default     = "ami-0cb91c7de36eed2cb"
}
