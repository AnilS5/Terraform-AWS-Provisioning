resource "aws_eip" "eip" {
  tags = {
    Name = "Elastic-IP"
  }
}