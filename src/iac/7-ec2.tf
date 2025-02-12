resource "aws_instance" "this" {
  ami                         = var.aws_ami
  instance_type               = var.aws_instance_type
  associate_public_ip_address = true
  availability_zone           = var.aws_availability_zone

  tags = {
    Name = var.aws_instance_name
  }

  vpc_security_group_ids = [aws_security_group.this.id]

  subnet_id = aws_subnet.this.id

  key_name = aws_key_pair.this.key_name

  # initial setup of VM; install all dependencies 
  user_data                   = file(var.aws_user_data)
  user_data_replace_on_change = true
}

