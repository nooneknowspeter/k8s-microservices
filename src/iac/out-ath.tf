output "ssh_private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "ssh_public_key" {
  value     = tls_private_key.this.public_key_openssh
  sensitive = true
}

