variable "project_name" {}

variable "ami_id" {}

variable "instance_type" {

default = "t3.medium"

}


variable "private_subnet_ids" {

type = list(string)

}


variable "security_group_id" {}


variable "min_size" {

default = 2

}


variable "max_size" {

default = 5

}


variable "desired_capacity" {

default = 2

}