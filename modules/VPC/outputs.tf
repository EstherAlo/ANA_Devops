output "public_subnets-1" {
  value       = aws_subnet.public[0].id
  description = "The first public subnet"
}

output "public_subnets-2" {
  value       = aws_subnet.public[1].id
  description = "The first second subnet"
}

output "public_subnets-3" {
  value       = aws_subnet.public[2].id
  description = "The first second subnet"
}


output "private_subnets-1" {
  value       = aws_subnet.private[0].id
  description = "The first private subnet"
}

output "private_subnets-2" {
  value       = aws_subnet.private[1].id
  description = "The second private subnet"
}


output "private_subnets-3" {
  value       = aws_subnet.private[2].id
  description = "The third private subnet"
}


output "vpc_id" {
  value = aws_vpc.main.id
}


output "instance_profile" {
  value = aws_iam_instance_profile.ip.id
}