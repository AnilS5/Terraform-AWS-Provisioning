locals {
  az_names = data.aws_availability_zones.azs.names
}
resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone = local.az_names[0]

  tags = {
    Name = "Private-subnet"
  }
}