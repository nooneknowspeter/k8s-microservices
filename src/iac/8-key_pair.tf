resource "tls_private_key" "this" {
  algorithm = var.aws_ssh_key_type
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.aws_key_name
  public_key = tls_private_key.this.public_key_openssh

  provisioner "local-exec" { # Generate <aws_key_name>.pem" in current directory
    command = <<-EOT
      echo '${tls_private_key.this.private_key_pem}' > ./'${var.aws_key_name}'.pem
      chmod 400 ./'${var.aws_key_name}'.pem
    EOT
  }
}

