# create instance for bastion
resource "aws_instance" "bastion" {
  ami                         = var.ami-bastion
  instance_type               = var.instance-type-bastion
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair

 tags = merge(
    var.tags,
    {
      Name = "ANA-BASTION"
    },
  )
}


#create instance for website
resource "aws_instance" "website" {
  ami                         = var.ami-sonar
  instance_type               = var.instance-type-artifact-sonar
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair


   tags = merge(
    var.tags,
    {
      Name = "ANA-WEBSITE"
    },
  )
}

