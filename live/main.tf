provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = {
      Terraform = "yes"
    }
  }
}

module "vpc" {
  source          = "../terraform-modules/vpc"
  region          = var.region
  environment     = var.environment
  service         = var.service
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  single_natgw    = var.single_natgw
}

module "db" {
  source             = "../terraform-modules/db"
  region             = var.region
  environment        = var.environment
  cluster_identifier = var.cluster_identifier
  engine             = var.engine
  engine_version     = var.engine_version
  database_name      = var.database_name
  master_username    = var.master_username
  engine_mode        = var.engine_mode
  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
  cidr_block         = module.vpc.vpc_cidr
}

module "ecs" {
  source        = "../terraform-modules/ecs"
  depends_on    = [module.db]
  region        = var.region
  environment   = var.environment
  subnets       = module.vpc.public_subnets
  vpc_id        = module.vpc.vpc_id
  instance_type = var.instance_type
  subnet_ids    = module.vpc.private_subnets
  clustername   = var.clustername
  desired_ecs   = var.desired_ecs
  min_ecs       = var.min_ecs
  max_ecs       = var.max_ecs
  zone_domain   = var.zone_domain
  zone_id       = var.zone_id
}
