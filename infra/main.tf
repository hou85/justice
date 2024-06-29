provider "aws" {
  region = "eu-west-3"
}


module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2_instances" {
  source = "./ec2_instances"
  vpc_id = module.vpc.vpc_id
  security_group_ids = module.security_groups.all_security_group_ids
}

module "rds_mongodb" {
  source = "./rds_mongodb"
  vpc_id = module.vpc.vpc_id
  security_group_ids = module.security_groups.db_security_group_id
}

module "load_balancers" {
  source = "./load_balancers"
  vpc_id = module.vpc.vpc_id
}

module "proxies" {
  source = "./proxies"
  vpc_id = module.vpc.vpc_id
  security_group_ids = module.security_groups.proxy_security_group_id
}

module "logging_monitoring" {
  source = "./logging_monitoring"
  vpc_id = module.vpc.vpc_id
  security_group_ids = module.security_groups.logging_monitoring_security_group_id
}

module "gitlab" {
  source = "./gitlab"
  vpc_id = module.vpc.vpc_id
  security_group_ids = module.security_groups.gitlab_security_group_id
}

module "kube_cluster" {
  source = "./kube_cluster"
  vpc_id = module.vpc.vpc_id
  security_group_ids = module.security_groups.kube_cluster_security_group_id
}

