output "alb_dns_name" {
  value       = aws_lb.ext-alb.dns_name
  description = "External load balance arn"
}

output "nginx-tgt" {
  description = "External Load balancaer target group"
  value       = aws_lb_target_group.nginx-tgt.arn
}


output "website-tgt" {
  description = "website target group"
  value       = aws_lb_target_group.wordpress-tgt.arn
}

