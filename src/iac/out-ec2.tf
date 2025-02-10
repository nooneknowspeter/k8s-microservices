output "instance_id" {
  value       = aws_instance.this.id
  description = "AWS Instance ID"
}

output "instance_type" {
  value       = aws_instance.this.instance_type
  description = "AWS Instance Type"
}

output "instance_public_ip" {
  value       = aws_instance.this.public_ip
  description = "AWS Instance Public IP Address"
}

output "instance_private_ip" {
  value       = aws_instance.this.private_ip
  description = "AWS Instance Private IP Address"
}

output "instance_public_dns" {
  value       = aws_instance.this.public_dns
  description = "AWS Instance Public DNS"
}

output "instance_user_data" {
  value       = aws_instance.this.user_data
  description = "AWS Instance User Data"
}

