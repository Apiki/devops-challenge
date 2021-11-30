variable "ami" {
        default = {
        "ubuntu18lts" = "ami-09889d8d54f9e0a0e"
    }
}

variable "instance" {
        default = {
        "free" = "t2.micro"
    }
}