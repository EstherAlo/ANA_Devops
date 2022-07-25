# ---- Autoscaling for WEBSITE

resource "aws_autoscaling_group" "website-asg" {
  name                      = "website-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health-check-grace-period
  health_check_type         = var.health-check-type
  desired_capacity          = var.desired_capacity

  # Where you place in your subnet
  vpc_zone_identifier = var.private_subnets


  launch_template {
    id      = aws_launch_template.wordpress-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "ACS-wordpress"
    propagate_at_launch = true
  }

}

# attaching autoscaling group of website to internal load balancer
resource "aws_autoscaling_attachment" "asg_attachment_wordpress" {
  autoscaling_group_name = aws_autoscaling_group.website-asg.id
  lb_target_group_arn   = var.wordpress-alb-tgt