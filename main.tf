#############################
##creating bucket for s3 backend
#########################
resource "aws_s3_bucket" "terraform-state" {
  bucket        = "pbl18"
  force_destroy = true

}

resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "first" {
  bucket = aws_s3_bucket.terraform-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# creating VPC
module "VPC" {
  source                              = "./modules/VPC"
  region                              = var.region
  vpc_cidr                            = var.vpc_cidr
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  enable_classiclink                  = var.enable_classiclink
  preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  private_subnets                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}

#Module for Application Load balancer, this will create Extenal Load balancer and internal load balancer
module "ALB" {
  source                  = "./modules/ALB"
  ext-alb-name            = "ACS-EXT-ALB"
  int-alb-name            = "ACS-INT-ALB"
  vpc-id                  = module.VPC.vpc_id
  public-sg               = module.Security.ALB-sg
  private-sg              = module.Security.IALB-sg
  public-sbn-1            = module.VPC.public_subnets-1
  public-sbn-2            = module.VPC.public_subnets-2
  public-sbn-2            = module.VPC.public_subnets-3
  private-sbn-1           = module.VPC.private_subnets-1
  private-sbn-2           = module.VPC.private_subnets-2
  private-sbn-2           = module.VPC.private_subnets-3
  load-balancer-type      = "application"
  ip-address-type         = "ipv4"
  protocol                = "HTTPS"
  target-type             = "instance"
  port                    = 443
  lb-listener-priority    = 99
  interval                = 10
  path                    = "/healthstatus"
  timeout                 = 5
  healthy-threshold       = 5
  unhealthy-threshold     = 2
  lb-listener-action-type = "forward"
}

module "Security" {
  source = "./modules/Security"
  vpc_id = module.VPC.vpc_id
}


module "AutoScaling" {
  source                    = "./modules/Autoscaling"
  ami-web                   = var.ami-web
  ami-bastion               = var.ami-bastion
  ami-nginx                 = var.ami-nginx
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  web-sg                    = [module.Security.web-sg]
  bastion-sg                = [module.Security.bastion-sg]
  nginx-sg                  = [module.Security.nginx-sg]
  wordpress-alb-tgt         = module.ALB.web-tgt
  nginx-alb-tgt             = module.ALB.nginx-tgt
  instance_profile          = module.VPC.instance_profile
  public_subnets            = [module.VPC.public_subnets-1, module.VPC.public_subnets-2]
  private_subnets           = [module.VPC.private_subnets-1, module.VPC.private_subnets-2]
  keypair                   = var.keypair
  instance_type             = "t2.micro"
  resource_type             = "instance"
  bastion-launch-name       = "bastion-launch-template"
  wordpress-launch-name     = "web-launch-template"
  health-check-grace-period = 300
  health-check-type         = "ELB"
}

