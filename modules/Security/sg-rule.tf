# creating dynamic ingress security groups
locals {
  security_groups = {
    ext-alb-sg = {
      name        = "ext-alb-sg"
      description = "for external loadbalncer"
    }

    # security group for bastion
    bastion-sg = {
      name        = "bastion-sg"
      description = "for bastion instances"
    }

    # security group for nginx
    nginx-sg = {
      name        = "nginx-sg"
      description = "nginx instances"
    }

    # security group for IALB
    int-alb-sg = {
      name        = "int-alb-sg"
      description = "IALB security group"
    }


    # security group for webservers
    webserver-sg = {
      name        = "webserver-sg"
      description = "webservers security group"
    }


    # security group for data-layer
    datalayer-sg = {
      name        = "datalayer-sg"
      description = "data layer security group"


    }
  }
}

##############################################################

# # security group for alb, to allow acess from anywhere on port 80 & 443.
# resource "aws_security_group" "ext-alb-sg" {
#   name        = "ext-alb-sg"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "EXT-ALB-SG"
#   }
# }


# # Security group for bastion to allow access into the bastion host from your IP
# resource "aws_security_group" "bastion-sg" {
#   name        = "bastion-sg"
#   description = "Allow incoming HTTP connections."
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name        = "BASTION-SG"
#     Environment = var.environment
#   }
# }

# # Security group for nginx reverse proxy to allow access only from the external load balancer and bastion instance 
# resource "aws_security_group" "nginx-sg" {
#   name   = "nginx-sg"
#   vpc_id = aws_vpc.main.id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "NGINX-SG"
#   }
# }



# # Security group for internal alb, to have access only from nginx reverse proxy server
# resource "aws_security_group" "int-alb-sg" {
#   name   = "int-alb-sg"
#   vpc_id = aws_vpc.main.id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "INT-ALB-SG"
#   }
# }



# # Security group for webservers, to have access only from the internal load balancer and bastion instance
# resource "aws_security_group" "webserver-sg" {
#   name   = "webserver-sg"
#   vpc_id = aws_vpc.main.id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "WEBSERVER-SG"
#   }
# }



# # Security group for datalayer to allow traffic from webserver on nfs and mysql port ann bastion host on mysql
# resource "aws_security_group" "datalayer-sg" {
#   name   = "datalayer-sg"
#   vpc_id = aws_vpc.main.id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "DATALAYER-SG"
#   }
# }


