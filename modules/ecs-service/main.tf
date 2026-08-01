##########################
# ECS Task Definition
##########################

resource "aws_ecs_task_definition" "this" {
family = var.service_name
network_mode = "bridge"
requires_compatibilities = [
"EC2"
]

cpu = var.cpu
memory = var.memory

container_definitions = jsonencode([

{

name = var.service_name

image = var.container_image

portMappings = [

{

containerPort = var.container_port

hostPort = var.container_port

}

]


}

])

}



##########################
# ECS Service
##########################

resource "aws_ecs_service" "this" {

  name = var.service_name

  cluster = var.cluster_id

  task_definition = aws_ecs_task_definition.this.arn

  desired_count = var.desired_count

}