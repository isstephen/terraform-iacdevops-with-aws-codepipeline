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

