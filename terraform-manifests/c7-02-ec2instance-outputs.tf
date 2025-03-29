## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of public instance IDs"
  value       = module.ec2-public.id
}

## output ec2_bastion_public_ip
output "ec2_bastion_eip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2-public.public_ip
}

##   For APP1
## output ec2_private_instance_ids
output "app1_ec2_private_instance_ids" {
  description = "List of private instance IDs"
  value = [for ec2private in module.ec2-private-app1 : ec2private.id]
}

## output ec2_private_ip
output "app1_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2-private-app1 : ec2private.private_ip]
}

## For APP2
## output ec2_private_instance_ids
output "app2_ec2_private_instance_ids" {
  description = "List of private instance IDs"
  value = [for ec2private in module.ec2-private-app2 : ec2private.id]
}

## output ec2_private_ip
output "app2_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2-private-app2 : ec2private.private_ip]
}
