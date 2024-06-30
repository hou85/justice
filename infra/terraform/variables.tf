variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-3"
}

variable "ami" {
  description = "The AMI ID for the instance."
  default     = "ami-085eba0f468ef2524" 
}


variable "instance_type_kube" {
  description = "The EC2 instance type for kube"
  type        = string
  default     = "t2.medium"
}

variable "instance_type_proxy" {
  description = "The EC2 instance type for kube"
  type        = string
  default     = "t2.medium"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 1
}

variable "instance_type_log" {
  description = "The EC2 instance type for kube"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = "terraform"
}



