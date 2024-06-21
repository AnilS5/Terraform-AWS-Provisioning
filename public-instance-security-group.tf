resource "aws_security_group" "public-sg" {
  name   = "public-sg"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = [22]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Public-sg"
  }
}