variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-3"
}

variable "ami" {
  description = "The AMI ID for the instance."
  default     = "ami-085eba0f468ef2524" 
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "c5.xlarge"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = "runner"
}

variable "gitlab_token" {
  description = "GitLab Personal Access Token"
  type        = string
  sensitive   = true
}
variable gitlab_runner_tags {
  description = "Gitlab Runner tag list (comma separated)."
  default = "test"
}

variable "gitlab_project_id" {
  description = "GitLab Project ID"
  type        = string
}


