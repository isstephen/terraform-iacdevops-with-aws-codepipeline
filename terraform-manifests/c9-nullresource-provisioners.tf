resource "null_resource" "name" {
  depends_on = [module.ec2-public, module.vpc]

  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    private_key = file("${path.module}/private-key/terraform-key.pem")
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      # Write the contents of the key to a file on the remote EC2 instance
      "echo '${replace(file("${path.module}/private-key/terraform-key.pem"), "\n", "\\n")}' | tr '\\n' '\n' | sudo tee /home/ec2-user/terraform-key.pem > /dev/null",


      # Set correct ownership and permissions
      "sudo chown ec2-user:ec2-user /home/ec2-user/terraform-key.pem",
      "sudo chmod 400 /home/ec2-user/terraform-key.pem"
    ]
  }
}
