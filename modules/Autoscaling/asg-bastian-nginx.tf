# Get list of availability zones
data "aws_availability_zones" "available-bastion" {
  state = "available"
}

# creating sns topic for all the auto scaling groups
resource "aws_sns_topic" "ACS-sns" {
  name = "Default_CloudWatch_Alarms_Topic"
}


# creating notification for all the auto scaling groups
resource "aws_autoscaling_notification" "aws_notifications" {
  group_names = [
    aws_autoscaling_group.bastion-asg.name,
    aws_autoscaling_group.nginx-asg.name,
    aws_autoscaling_group.wordpress-asg.name,
    
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.ACS-sns.arn
}


resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available-bastion.names
}


# ---- Autoscaling for bastion  hosts
resource "aws_autoscaling_group" "bastion-asg" {
  name                      = "bastion-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health-check-grace-period
  health_check_type         = var.health-check-type
  desired_capacity          = var.desired_capacity

  # Where you place in your subnet
  vpc_zone_identifier = var.public_subnets

  launch_template {
    id      = aws_launch_template.bastion-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "ACS-Bastion"
    propagate_at_launch = true
  }

}


# ------ Autoscaling group for reverse proxy nginx ---------
resource "aws_autoscaling_group" "nginx-asg" {
  name                      = "nginx-asg"
  max_size                  = var.max_size
  min_size                  = 1
  health_check_grace_period = var.health-check-grace-period
  health_check_type         = var.health-check-type
  desired_capacity          = 1

  vpc_zone_identifier = var.public_subnets


  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ACS-nginx"
    propagate_at_launch = true
  }

}

# attaching autoscaling group of nginx to external load balancer
resource "aws_autoscaling_attachment" "asg_attachment_nginx" {
  autoscaling_group_name = aws_autoscaling_group.nginx-asg.id
  lb_target_group_arn   = var.nginx-alb-tgt
}