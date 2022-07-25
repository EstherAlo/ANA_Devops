variable "subnets-compute" {
    description = "public subnetes for compute instances"
}
variable "ami-web" {
    type = string
    description = "ami for web"
}
variable "ami-bastion" {
    type = string
    description = "ami for bastion"
}

variable "sg-compute" {
    description = "security group for compute instances"
}
variable "keypair" {
    type = string
    description = "keypair for instances"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
