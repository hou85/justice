terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "git" {
  backend = "s3"
  config = {
    bucket = "projet-justice"
    key    = "git/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = "http://${data.terraform_remote_state.git.outputs.instance_public_ip}:7000"
}

module "gitlab_security_group" {
  source = "./security_group"
}


data "gitlab_project" "projet" {
  id = var.gitlab_project_id
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.sh")}"
  vars = {
    GITLAB_RUNNER_URL                     = "http://${data.terraform_remote_state.git.outputs.instance_public_ip}:7000"
    GITLAB_RUNNER_TOKEN                   = "${data.gitlab_project.projet.runners_token}" 
    GITLAB_RUNNER_TAGS                    = "${var.gitlab_runner_tags}"
  }
}


resource "aws_instance" "gitlab_runner" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  user_data       = "${data.template_file.user_data.rendered}" 

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

output "runner_registration_token" {
  value = data.gitlab_project.projet.runners_token
}
