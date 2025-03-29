module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name    = "${local.name}-loadbalancer-sg"
  description = "Security Group with HTTP open for entire internet (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  # ingress rules & CIDR blocks
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Open to CIDRs blocks (rule or from_port+to_port+protocol+description)
  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      protocol    = 6
      to_port     = 81
      description = "Allow Port 81 from internet"
      cidr_blocks = "0.0.0.0/0"
  },
  ]

  # egress rules- all ports all proto
  egress_rules = ["all-all"]
  tags = local.common_tags

}