variable "aws_region" {
  default = "us-east-1"
}

variable "engine" {
  default     = "mysql"
  description = "An engine to use for the database"
}

variable "allocated_storage" {
  default     = "5"
  description = "Allocation storage size"
}

variable "storage_type" {
  default     = "gp2"
  description = "Storage type"
}

variable "username" {
  default     = "admin"
  description = "Database username"
}

variable "password" {
  default     = "EgiePh8Gish7"
  description = "Database password"
}

variable "db_instance_class" {
  default     = "db.t2.micro"
  description = "Database instance class"
}

variable "parameter_group_name" {
  default     = "default.mysql5.7"
  description = "Database parameter group name"
}

variable "engine_version" {
  default     = "5.7.28"
  description = "Database engine version"
}

variable "identifier_db_name" {
  default     = "devops-test-wordpress"
  description = "Database identifier name"
}

variable "port" {
  default     = "3306"
  description = "Database port"
}

variable "db_name" {
  default     = "wordpress_database"
  description = "Database name"
}

variable "aws_amis" {
  default = {
    "us-east-1" = "ami-04505e74c0741db8d"
  }
}

variable "instance_type" {
  default = "t2.micro"
}
