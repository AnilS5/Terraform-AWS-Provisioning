resource "aws_route_table_association" "public-rt-asscociation" {
  count          = length(slice(local.az_names, 0, 2))
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-rt.id
}