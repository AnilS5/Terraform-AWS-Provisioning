resource "aws_lb_target_group" "target-group" {
  name     = "target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}