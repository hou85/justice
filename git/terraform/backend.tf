terraform {
  backend "s3" {
    bucket = "projet-justice"
    key    = "git/terraform.tfstate"
    region = "eu-west-3"
  }
}
