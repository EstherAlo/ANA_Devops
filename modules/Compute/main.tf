# create instance for jenkins
resource "aws_instance" "Jenkins" {
  ami                         = var.ami-jenkins
  instance_type               = var.instance-type-jenkins
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair

 tags = merge(
    var.tags,
    {
      Name = "ACS-JENKINS"
    },
  )
}


#create instance for sonbarqube
resource "aws_instance" "sonbarqube" {
  ami                         = var.ami-sonar
  instance_type               = var.instance-type-artifact-sonar
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair


   tags = merge(
    var.tags,
    {
      Name = "ACS-SONARQUBE"
    },
  )
}

# create instance for artifactory
resource "aws_instance" "artifactory" {
  ami                         = var.ami-jfrog
  instance_type               = var.instance-type-artifact-sonar
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = var.sg-compute
  associate_public_ip_address = true
  key_name                    = var.keypair


  tags = merge(
    var.tags,
    {
      Name = "ACS-ARTIFACTORY"
    },
  )
}