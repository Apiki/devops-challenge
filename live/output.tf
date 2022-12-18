//Show VPC_ID output
output "vpc_id" {
  value = module.vpc.vpc_id
}

//Show Private_Subnets output
output "private_subnets" {
  value = module.vpc.private_subnets
}

//Show Public_Subnets output
output "public_subnets" {
  value = module.vpc.public_subnets
}

//Show CIDR VPC output
output "cidr_block" {
  value = module.vpc.vpc_cidr
}

//Show RDS Endpoint output
output "db_endpoint" {
  value = module.db.aurora_endpoint
}

//Show ALB DNS URL output
output "alb_dns" {
  value = module.ecs.alb_dns_name
}
