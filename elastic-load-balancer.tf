resource "aws_lb" "elastic-lb" {
  name               = "elastic-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb-sg.id]
  subnets            = [for subnet in aws_subnet.public-subnet : subnet.id]

  # enable_deletion_protection = true

  #access_logs {
  #  bucket  = aws_s3_bucket.mybucket.id
  #  prefix  = var.prefix
  #  enabled = true
  #}

  idle_timeout = 400



  tags = {
    Name = "elastic-lb-${terraform.workspace}"
  }

}