resource "aws_instance" "this" {
  ami                         = var.aws_ami
  instance_type               = var.aws_instance_type
  associate_public_ip_address = true
  tags = {
    Name = var.aws_instance_name
  }
}

