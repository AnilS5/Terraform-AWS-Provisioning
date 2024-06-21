resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
    Name = "Nat-gateway"
  }
}