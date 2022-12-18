//Create Launch Configuration
resource "aws_launch_configuration" "ecs_launch_configuration" {
  name                 = "${var.environment}-instance-asg-${var.region}"
  image_id             = data.aws_ami.asg-ami.id
  iam_instance_profile = aws_iam_instance_profile.asg-profile.name
  security_groups      = [aws_security_group.asg-sg.id]
  user_data            = templatefile("${path.module}/user_data.sh", { clustername = var.clustername })
  instance_type        = var.instance_type
}

//Create Auto Scaling Group
resource "aws_autoscaling_group" "ecs_autoscaling" {
  name                      = "${var.environment}-asg-autoscaling-group-${var.region}"
  vpc_zone_identifier       = var.subnet_ids
  launch_configuration      = aws_launch_configuration.ecs_launch_configuration.name
  desired_capacity          = var.desired_ecs
  min_size                  = var.min_ecs
  max_size                  = var.max_ecs
  health_check_grace_period = 300
  health_check_type         = "EC2"

  tag {
    key                 = "Name"
    value               = "${var.environment}-containerservice-cluster-${var.region}"
    propagate_at_launch = true
  }
}

# Up auto scaling policy
resource "aws_autoscaling_policy" "cpu_auto" {
  name                   = "${var.environment}-cpu-autoscaling"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ecs_autoscaling.name
}

#Create cloudwatch alarm monitoring
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
  alarm_name          = "${var.environment}-cpu-alarm-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_autoscaling.name
  }

  alarm_description = "This metric monitors asg-ecs cpu utilization"
  actions_enabled   = true
  alarm_actions     = [aws_autoscaling_policy.cpu_auto.arn]
}

# Down auto scaling policy
resource "aws_autoscaling_policy" "cpu_down" {
  name                   = "${var.environment}-cpu-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ecs_autoscaling.name
}

#Create cloudwatch alarm monitoring down
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_down" {
  alarm_name          = "${var.environment}-cpu-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu_down.arn]
}
