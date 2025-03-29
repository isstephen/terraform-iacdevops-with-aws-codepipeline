# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name         = "ssl-trading.com"
  #private_zone = true
}

# Output MyDomain Zone ID
output "mydomain_zoneid" {
  description = "Hosted Zone id of the desired Hosted Zone"
  value = data.aws_route53_zone.mydomain.zone_id
}

# Output MyDomain Zone Name
output "mydomain_zonename" {
  description = "Hosted Zone name of the desired Hosted Zone"
  value = data.aws_route53_zone.mydomain.name
}