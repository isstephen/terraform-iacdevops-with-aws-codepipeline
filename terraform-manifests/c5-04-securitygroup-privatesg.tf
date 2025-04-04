module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name    = "${local.name}-private-sg"
  description = "Security Group with HTTP& SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  # ingress rules & CIDR blocks
  ingress_rules = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # egress rules- all ports all proto
  egress_rules = ["all-all"]
  tags = local.common_tags

}