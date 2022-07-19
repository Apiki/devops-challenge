
variable "instance_type" {
    default = "t2.micro"
}

variable "namespace" {
  type = string
}

variable key_name {
  type = string
}

variable "vpc" {
  type = any
}

variable "sg_pub_id" {
  type = any
}


