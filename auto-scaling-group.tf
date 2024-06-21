resource "aws_launch_configuration" "as-conf" {
  name            = "public-instance-configuration"
  image_id        = var.ami_image
  instance_type   = var.instance_type
  security_groups = [aws_security_group.elb-sg.id, aws_security_group.public-sg.id]
  user_data       = file("install-apache.sh")
}

resource "aws_autoscaling_group" "public-as-group" {
  name                      = "public-as-group"
  launch_configuration      = aws_launch_configuration.as-conf.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  vpc_zone_identifier       = [aws_subnet.public-subnet[0].id]
  desired_capacity          = 1
  force_delete              = true
  termination_policies      = ["OldestInstance"]
  #availability_zones        = [local.az_names[1]]

  instance_maintenance_policy {
    min_healthy_percentage = 50
    max_healthy_percentage = 100
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [desired_capacity, target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "as-attachment" {
  autoscaling_group_name = aws_autoscaling_group.public-as-group.id
  #elb                    = aws_lb.elastic-lb.id
  lb_target_group_arn    = aws_lb_target_group.target-group.arn
}

resource "aws_autoscaling_policy" "scaleup-policy" {
  name                   = "scaleup-policy"
  autoscaling_group_name = aws_autoscaling_group.public-as-group.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 120
}

resource "aws_cloudwatch_metric_alarm" "as-scaleup" {
    alarm_name = "as-scaleup"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 80

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.public-as-group.name
    }

    alarm_actions = [aws_autoscaling_policy.scaleup-policy.arn]
}


resource "aws_autoscaling_policy" "scaledown-policy" {
  name                   = "scaledown-policy"
  autoscaling_group_name = aws_autoscaling_group.public-as-group.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = 120
}

resource "aws_cloudwatch_metric_alarm" "as-scaledown" {
    alarm_name = "as-scaledown"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 40

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.public-as-group.name
    }

    alarm_actions = [aws_autoscaling_policy.scaledown-policy.arn]
}