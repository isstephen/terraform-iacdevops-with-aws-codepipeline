# ACM Module - To create and verify SSL Certificates

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"

  domain_name  = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
  zone_id      = data.aws_route53_zone.mydomain.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    # "*.ssl-trading.com",
    var.dns_name
  ]

  wait_for_validation = true

  tags = local.common_tags
}

# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}