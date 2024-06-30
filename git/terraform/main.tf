provider "aws" {
  region = var.region
}

module "gitlab_security_group" {
  source = "./security_group"
}

resource "aws_instance" "gitlab" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ../../runner/ansible/ip_address.txt"
  }

  tags = {
    Name = "GitLab-Server"
  }
}

