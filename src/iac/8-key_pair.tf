resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.aws_key_name
  public_key = tls_private_key.this.public_key_openssh

  provisioner "local-exec" { # Generate aws_ssh.pem" in current directory
    command = <<-EOT
      echo '${tls_private_key.this.private_key_pem}' > ./aws_ssh.pem
      chmod 400 ./aws_ssh.pem
    EOT
  }
}

