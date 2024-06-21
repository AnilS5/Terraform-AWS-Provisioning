resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  count                   = length(slice(local.az_names, 0, 2))
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + 2)
  availability_zone       = local.az_names[count.index + 1]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet-${count.index + 1}"
  }
}