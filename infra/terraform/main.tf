provider "aws" {
  region = var.region
}

module "gitlab_security_group" {
  source = "./security_group"
}

resource "aws_instance" "k8s_master" {
  ami             = var.ami
  instance_type   = var.instance_type_kube
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  tags = {
    Name = "k8s-master"
    Role = "master"
  }
}

resource "aws_instance" "k8s_worker" {
  count           = var.worker_count
  ami             = var.ami
  instance_type   = var.instance_type_kube
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  
  tags = {
    Name = "k8s-worker-${count.index + 1}"
    Role = "worker"
  }
}

resource "aws_instance" "proxy_internal" {
  ami             = var.ami
  instance_type   = var.instance_type_proxy
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  tags = {
    Name = "proxy-internal"
    Role = "internal"
  }
}

resource "aws_instance" "proxy_external" {
  ami             = var.ami
  instance_type   = var.instance_type_proxy
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  tags = {
    Name = "proxy-external"
    Role = "external"
  }
}

resource "aws_instance" "mongodb" {
  ami             = var.ami
  instance_type   = var.instance_type_proxy
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  tags = {
    Name = "mongodb"
    Role = "mongodb"
  }
}

resource "aws_instance" "logging" {
  ami             = var.ami
  instance_type   = var.instance_type_log
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  tags = {
    Name = "logging"
    Role = "logging"
  }
}

resource "aws_instance" "monitoring" {
   ami             = var.ami
  instance_type   = var.instance_type_log
  key_name        = var.key_name
  security_groups = [module.gitlab_security_group.security_group_name]
  tags = {
    Name = "monitoring"
    Role = "monitoring"
  }
}