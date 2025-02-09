resource "aws_security_group" "this" {
  name        = var.aws_security_group_name
  description = "Allow All Traffic"
  vpc_id      = aws_vpc.this.id
}
