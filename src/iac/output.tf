output "instance_id" {
  value       = aws_instance.this.id
  description = "AWS Instance ID"
}

output "instance_public_ip" {
  value       = aws_instance.this.public_ip
  description = "AWS Instance Public IP Address"
}

output "instance_private_ip" {
  value       = aws_instance.this.private_ip
  description = "AWS Instance Private IP Address"
}

