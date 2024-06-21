resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.cidr_block
    #gateway_id = "local"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "Private-route-table"
  }
}