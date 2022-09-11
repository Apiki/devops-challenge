variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/22"
}

variable "public_subnet" {
  type        = string
  description = "CIDR Block for Public Subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet" {
  type        = string
  description = "CIDR Block for Private Subnet"
  default     = "10.0.2.0/24"
}

# variable "vpc_subnets_cidr_blocks" {
#   type        = list(string)
#   description = "CIDR Blocks for Subnets in VPC"
#   default     = ["10.0.0.0/24", "10.0.1.0/24"]
# }

variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "juam.sv-corp"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default = "Apiki"
}

# variable "aws_access_key" {
#   type        = string
#   description = "AWS Access Key"
#   sensitive   = true
# }

# variable "aws_secret_key" {
#   type        = string
#   description = "AWS Secret Key"
#   sensitive   = true
# }

variable "aws_region" {
  type        = string
  description = "Region for AWS Resources"
  default     = "us-east-1"
}

variable "aws_az" {
  type        = string
  description = "Region for AWS Resources"
  default     = "us-east-1a"
}

#### RDS Variables ####
variable "engine" {
  description = "The database engine"
  type = string
  default = "mysql"
}
variable "allocated_storage" {
  description = "The amount of allocated storage."
  type = number
  default = 10
}
variable "storage_type" {
  description = "type of the storage"
  type = string
  default = "gp2"
}
variable "username" {
  description = "Username for the master DB user."
  default = "wordpress"
  type = string
}
variable "password" {
  description = "password of the database"
  default = "super@senha"
  type = string
}
variable "instance_class" {
  description = "The RDS instance class"
  default = "db.t2.micro"
  type = string
}
variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  default = "default.mysql5.7"
  type = string
}
variable "engine_version" {
  description = "The engine version"
  default = "5.7"
  type = number
}
variable "skip_final_snapshot" {
  description = "skip snapshot"
  default = "true"
  type = string
}
variable "identifier" {
  description = "The name of the RDS instance"
  default = "terraform-database-test"
  type = string
}
variable "port" {
  description = "The port on which the DB accepts connections"
  default = "3306"
  type = number
}
variable "name" {
  description = "The database name"
  default = "Mysqldatabase"
  type = string
}