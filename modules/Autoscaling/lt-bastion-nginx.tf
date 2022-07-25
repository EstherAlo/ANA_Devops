resource "aws_launch_template" "bastion-launch-template" {
  name                   = var.bastion-launch-name
  instance_type          = var.instance_type
  image_id               = var.ami-bastion
  vpc_security_group_ids = var.bastion-sg

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.keypair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = var.resource_type

    tags = {
      Name = var.bastion-launch-name
    }
  }

  user_data = filebase64("${path.module}/bastion.sh")
}

resource "aws_launch_template" "nginx-launch-template" {
  name                   = var.nginx-launch-name
  instance_type          = var.instance_type
  image_id               = var.ami-nginx
  vpc_security_group_ids = var.nginx-sg

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.keypair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = var.resource_type


    tags = {
      Name = var.nginx-launch-name
    }
  }

  user_data = filebase64("${path.module}/nginx.sh")
}