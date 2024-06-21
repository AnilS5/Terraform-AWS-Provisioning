resource "aws_security_group_rule" "allow-elb-only" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "8080"
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block]
  security_group_id = aws_security_group.public-sg.id
}