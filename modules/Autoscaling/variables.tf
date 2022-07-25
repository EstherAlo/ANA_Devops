variable "ami-web" {
  type        = string
  description = "ami for webservers"
}

variable "instance_profile" {
  type        = string
  description = "Instance profile for launch template"
}


variable "keypair" {
  type        = string
  description = "Keypair for instances"
}

variable "ami-bastion" {
  type        = string
  description = "ami for bastion"
}

variable "web-sg" {
  type = list
  description = "security group for webservers"
}

variable "bastion-sg" {
  type = list
  description = "security group for bastion"
}

variable "nginx-sg" {
  type = list
  description = "security group for nginx"
}

variable "private_subnets" {
  type = list
  description = "first private subnets for internal ALB"
}


variable "public_subnets" {
  type = list
  description = "Second subnet for ecternal ALB"
}


variable "ami-nginx" {
  type        = string
  description = "ami for nginx"
}

variable "nginx-alb-tgt" {
  type        = string
  description = "nginx reverse proxy target group"
}

variable "web-alb-tgt" {
  type        = string
  description = "web target group"
}


variable "max_size" {
  type        = number
  description = "maximum number for autoscaling"
}

variable "min_size" {
  type        = number
  description = "minimum number for autoscaling"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instance in autoscaling group"

}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}


variable "instance_type" {
  type        = string
  description = "type of instance"
}

variable "resource_type" {
  type        = string
  description = "resource type"
}


variable "bastion-launch-name" {
   type        = string
  description = "launch template name"
}

variable "nginx-launch-name" {
   type        = string
  description = "launch template name"
}


variable "wordpress-launch-name" {
   type        = string
  description = "launch template name"
}

variable "health-check-grace-period" {
  type        = number
  description = "health check grace period"
}

variable "health-check-type" {
  type        = string
  description = "health check type"
}