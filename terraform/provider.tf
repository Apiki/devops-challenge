provider "aws" {
  shared_credentials_files = ["credentials"]
  profile                  = "default"
  region                   = var.aws_region
}