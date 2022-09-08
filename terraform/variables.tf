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
  default     = "10.0.1.0/24"
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