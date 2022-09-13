terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  # backend "s3" {
  # bucket = "terraform-lab-madra"
  # key    = "terraform-test.tfstate"
  # region = "us-east-2"
  # }
}

# Configure the AWS Provider
provider "aws" {
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
  region     = var.aws_region
}