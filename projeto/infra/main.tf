provider "aws" {
    region = "us-east-1"
}

module "networking" {
  source = "./modules/networking"
  namespace = var.namespace
}


module "ssh-key" {
  source    = "./modules/ssh-key"
  namespace = var.namespace
}

module "ec2-instance" {
  source = "./modules/ec2"
#   ami_id = "ami-0c2d06d50ce30b442"
  namespace  = var.namespace
  instance_type = "t2.micro"
  vpc        = module.networking.vpc
  sg_pub_id  = module.networking.sg_pub_id
  key_name   = module.ssh-key.key_name
} 