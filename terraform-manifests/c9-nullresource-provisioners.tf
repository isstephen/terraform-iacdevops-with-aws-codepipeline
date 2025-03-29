# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [module.ec2-public, module.vpc]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    private_key = file("/Users/yangyang/repos/terraform-on-aws/07-AWS-EC2Instance-and-SecurityGroups/terraform-manifests/private-key/terraform-key.pem")
    agent        = false
  }

provisioner "remote-exec" {
  inline = [
    // Write the contents via sudo, using "tee"
    "echo '${file("/Users/yangyang/repos/terraform-on-aws/07-AWS-EC2Instance-and-SecurityGroups/terraform-manifests/private-key/terraform-key.pem")}' | sudo tee /home/ec2-user/terraform-key.pem",

    // Set correct ownership and permissions
    "sudo chown ec2-user:ec2-user /home/ec2-user/terraform-key.pem",
    "sudo chmod 400 /home/ec2-user/terraform-key.pem"
  ]
}
  /*
  ## local Exec provisioner (destroy time provisioner - trigger during deletion of Resource)
  provisioner "local-exec" {
    command     = "echo create time prov `date`: >> destroy-time-provid.txt"
    working_dir = "local-exec-output-files/"
    #when = destroy
    #on_failure = continue
  }
  */
}