terraform {
  required_version = "~> 1.2.0" # 1.2.0 até 1.2.n

}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }

  backend "s3" {

    bucket  = "apiki-mateusassis02"
    key     = "apiki-mateusassis.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

  # Configure the AWS Provider
  provider "aws" {
    region = "us-east-2"
  

  default_tags {
    tags = {
      nome      = "mateusassis02"
      managed-by = "Apiki"
    }
  }
}

