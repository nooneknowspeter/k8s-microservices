variable "aws_profile" {
  type        = string
  description = "AWS Profile"
  default     = "default"
}

variable "aws_key_name" {
  type        = string
  description = "AWS Key Pair Name"
}

variable "aws_public_key" {
  type        = string
  description = "SSH Public Key"
}

variable "aws_ssh_key_type" {
  type        = string
  description = "SSH Key Type"
  default     = "RSA"
}

