variable "ext-alb-name" {
    type = string
    description = "name of the loadbalancer"
  
}

variable "int-alb-name" {
    type = string
    description = "name of the loadbalancer"
  
}

variable "vpc-id" {
  type        = string
  description = "The vpc ID"
}

# The security froup for external loadbalancer
variable "public-sg" {
  description = "Security group for external load balancer"
}

# The public subnet group for external loadbalancer
variable "public-sbn-1" {
  description = "Public subnets to deploy external ALB"
}
variable "public-sbn-2" {
  description = "Public subnets to deploy external  ALB"
}
variable "public-sbn-3" {
  description = "Public subnets to deploy external  ALB"
}

variable "private-sg" {
  description = "Security group for Internal Load Balancer"
}

variable "private-sbn-1" {
  description = "Private subnets to deploy Internal ALB"
}
variable "private-sbn-2" {
  description = "Private subnets to deploy Internal ALB"
}
variable "private-sbn-3" {
  description = "Private subnets to deploy Internal ALB"
}

variable "load-balancer-type" {
  type        = string
  description = "the type of Load Balancer"
}

variable "ip-address-type" {
  type        = string
  description = "IP address for the ALB"

}

variable "protocol" {
  type = string
  description = "type of protocol"
}

variable "target-type" {
  type = string
  description = "load balancer type"
}

variable "port" {
  type = number
  description = "port number"
}


variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "lb-listener-priority" {
  type = number
  description = "priority rate"
}

variable "interval" {
  type = number
  description = "interval to check for the health status"
}

variable "path" {
  type = string
  description = "path to health status directory"
}

variable "timeout" {
  type = number
  description = "time out"
}

variable "healthy-threshold" {
  type = number
  description = "healthy threshold"
}

variable "unhealthy-threshold" {
  type = number
  description = "unhealthy threshold"
}

variable "lb-listener-action-type" {
  type = string
  description = "type of action"
}
