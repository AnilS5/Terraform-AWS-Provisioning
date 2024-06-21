resource "aws_route_table_association" "private-rt-asscociation" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}