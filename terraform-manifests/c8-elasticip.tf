# create elastic IP for Bastion Host
# Resource: aws_eip
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

resource "aws_eip" "bastion_eip" {
  depends_on = [
    module.ec2-public, module.vpc
  ]
  instance = module.ec2-public.id
  domain   = "vpc"
  tags = local.common_tags
}