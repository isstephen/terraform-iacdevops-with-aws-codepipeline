module "rds_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name    = "rdsdb-sg"
  description = "Access to MySQL DB for entire VPC CIDR Block"
  vpc_id = module.vpc.vpc_id

  # ingress rules & CIDR blocks
  #ingress_rules = ["ssh-tcp", "http-80-tcp"]

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]  # ✅ Expecting a list of CIDR strings
  ingress_rules       = ["mysql-tcp"]                # ✅ This predefined rule opens 3306/TCP

  # egress rules- all ports all proto
  egress_rules = ["all-all"]
  tags = local.common_tags

}