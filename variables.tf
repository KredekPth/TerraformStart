variable "aws_region" {
    default = "eu-west-1"
}

variable "amis" {
    default = "ami-02df9ea15c1778c9c"
    
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
    default = "10.0.10.0/24"
}

variable "public_subnet_cidr_b" {
    default = "10.0.2.0/24"
}

variable "private_subnet_cidr_b" {
    default = "10.0.20.0/24"
}