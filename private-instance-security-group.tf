resource "aws_security_group" "private-sg" {
  name   = "private-sg"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = [22, 443, 8080]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_block]
    }
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Private-sg"
  }
}