resource "aws_lb_target_group_attachment" "group-attachment" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.public-instance.id
  port             = 80
}

output "list_instances" {
  value = aws_lb_target_group_attachment.group-attachment
}