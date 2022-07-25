# The entire section create a certiface, public zone, and validate the certificate using DNS method

# calling the hosted zone
data "aws_route53_zone" "project_terraform_zone" {
  name         = "projectaws.xyz"
  private_zone = false
}

# Create the certificate using a wildcard for all the domains created in projectaws.xyz
resource "aws_acm_certificate" "project_terraform_cert" {
  domain_name       = "*.projectaws.xyz"
  validation_method = "DNS"
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "project_terraform_validation" {
  certificate_arn         = aws_acm_certificate.project_terraform_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.project_terraform_record : record.fqdn]
}

# selecting validation method
resource "aws_route53_record" "project_terraform_record" {
  for_each = {
    for dvo in aws_acm_certificate.project_terraform_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } 

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.project_terraform_zone.zone_id
}


# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.project_terraform_zone.zone_id
  name    = "website.projectaws.xyz"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}