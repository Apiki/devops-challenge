terraform {
  backend "s3" {
    key     = "terraform-state/wp"
    region  = "us-east-2"
    encrypt = true
  }
}
