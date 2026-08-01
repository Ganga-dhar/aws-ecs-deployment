##########################
# VPC
##########################


module "vpc" {

  source = "../../modules/vpc"

  project_name = var.project_name

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnets = var.public_subnets

  private_subnets = var.private_subnets
}

##########################
# ECS-CLUSTER
##########################

module "ecs_cluster" {

source = "../../modules/ecs-cluster"


project_name = var.project_name


private_subnet_ids = module.vpc.private_subnet_ids


security_group_id = aws_security_group.ecs.id


ami_id = "ami-0abcdef123456"


instance_type = "t3.medium"

}

##########################
# ECS-SERVICE
##########################

module "ecs_service" {

source = "../../modules/ecs-service"


service_name = "payment-api"


cluster_id =
module.ecs_cluster.cluster_id


container_image =
"nginx:latest"


container_port = 80


desired_count = 2

}