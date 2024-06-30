

provider "aws" {
  region = var.region
}


module "gitlab_security_group" {
  source = "./security_group"
}

resource "aws_instance" "gitlab_runner" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  tags = {
    Name = "GitLab Runner"
  }
}

output "instance_id" {
  value = aws_instance.gitlab_runner.id
}

output "instance_public_ip" {
  value = aws_instance.gitlab_runner.public_ip
}

output "instance_public_dns" {
  value = aws_instance.gitlab_runner.public_dns
}