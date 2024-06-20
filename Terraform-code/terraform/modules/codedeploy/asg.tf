##########################
## for ticket99/web-api ##
##########################


# define a launch template, which will be used by an autoscaling group
resource "aws_launch_template" "ticket99_auto_scaling_launch_template" {
  name_prefix   = "${var.APP_NAME}-${var.ENVIRONMENT}-codedeploy-launch-templates"
  iam_instance_profile {
    name = aws_iam_instance_profile.ticket99_iam_instance_profile.name
  }
  image_id      = var.CODEDEPLOY_INAGE_ID # Enter here your AMI id
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  user_data = base64encode(file("${path.module}/user_data.ps1"))
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.APP_NAME}-${var.ENVIRONMENT}-web-application" # Specify your desired instance name
      ENVIRONMENT  =  var.ENVIRONMENT
      SERVICE = var.SERVICE
    }
  }
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.EBS_VOLUME_SIZE
      volume_type = var.EBS_VOLUME_TYPE
    }
  }
  network_interfaces {
    associate_public_ip_address = true # Add this line to enable public IP
    security_groups = [aws_security_group.web_sg.id] # Move security groups here
  }
}

resource "aws_autoscaling_group" "ticket99_autoscaling_group" {
  name                      = "${var.APP_NAME}-${var.ENVIRONMENT}-codedeploy-asg"
  desired_capacity          = var.DESIRED_CAPACITY
  max_size                  = var.MAX_SIZE
  min_size                  = var.MIN_SIZE
  health_check_grace_period = 300
  force_delete              = true
  vpc_zone_identifier       = var.PUBLIC_SUBNET_ID
  target_group_arns = [
    aws_alb_target_group.t99_codedeploy_web_api.arn,
    aws_alb_target_group.t99_codedeploy_web_admin_api_tg.arn
  ]
  health_check_type = "EC2"
  launch_template {
    id      = aws_launch_template.ticket99_auto_scaling_launch_template.id
    version = "$Latest"
  }
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_scale_up_alarm" {
  alarm_name          = "CPU-utilization-on-instance"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "Alarm when CPU exceeds 70%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ticket99_autoscaling_group.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_out_policy.arn]
}

# Scaling Policies
resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ticket99_autoscaling_group.name
}

# CloudWatch Alarm for Scaling In
resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_scale_down_alarm" {
  alarm_name          = "scale-in-cpu-utilization"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "Alarm when CPU falls below 20%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ticket99_autoscaling_group.name
  }
  alarm_actions = [aws_autoscaling_policy.scale_in_policy.arn]
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ticket99_autoscaling_group.name
}



# ################################
# ## for ticket99/web-admin api ##
# ################################

# # define a launch template, which will be used by an autoscaling group
# resource "aws_launch_template" "ticket99_web_admin_auto_scaling_launch_template" {
#   name_prefix   = "${var.APP_NAME}-${var.ENVIRONMENT}-codedeploy-web-admin-lt"
#   iam_instance_profile {
#     name = aws_iam_instance_profile.ticket99_iam_instance_profile.name
#   }
#   image_id      = var.CODEDEPLOY_INAGE_ID # Enter here your AMI id
#   instance_type = var.INSTANCE_TYPE
#   vpc_security_group_ids = [aws_security_group.alb_web_admin_api_sg.id]
#   tags = {
#     Name = "${var.APP_NAME}-${var.ENVIRONMENT}-web-application" # Specify your desired instance name
#     Env  =  var.ENVIRONMENT
#   }
# }

# resource "aws_autoscaling_group" "ticket99_web_admin_autoscaling_group" {
#   name                      = "${var.APP_NAME}-${var.ENVIRONMENT}-codedeploy-web-admin-asg"
#   desired_capacity          = var.DESIRED_CAPACITY
#   max_size                  = var.MAX_SIZE
#   min_size                  = var.MIN_SIZE
#   health_check_grace_period = 300
#   health_check_type         = "EC2"
#   force_delete              = true
#   vpc_zone_identifier       = var.PUBLIC_SUBNET_ID
#   launch_template {
#     id      = aws_launch_template.ticket99_web_admin_auto_scaling_launch_template.id
#     version = "$Latest"
#   }
# }



#######################################################################################