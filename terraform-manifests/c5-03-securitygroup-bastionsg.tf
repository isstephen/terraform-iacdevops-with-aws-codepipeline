module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name    = "${local.name}-public-bastion-sg"
  description = "Security Group with SSH port open for everybody(IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  # ingress rules & CIDR blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # egress rules- all ports all proto
  egress_rules = ["all-all"]
  tags = local.common_tags
}