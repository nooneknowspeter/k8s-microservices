resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.aws_availability_zone
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 4, 1)
  map_public_ip_on_launch = true
}

