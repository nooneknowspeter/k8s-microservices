resource "aws_key_pair" "this" {
  key_name   = "aws_ssh"
  public_key = var.aws_public_key
}

