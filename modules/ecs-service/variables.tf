variable "service_name" {}


variable "cluster_id" {}


variable "container_image" {}


variable "container_port" {

default = 80

}


variable "cpu" {

default = 256

}


variable "memory" {

default = 512

}


variable "desired_count" {

default = 2

}