variable "cidr" {
    type = string
    description = "cidr of the vpc"
}


variable "internet" {
    type = string
    description = "route to internet"
    default = "0.0.0.0/0"
}

variable "ami" {
    type = string
    description = "ami of the ec2 instance"
}

variable "password" {
    type = string
    description = "password for rds database"
}