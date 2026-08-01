#############################
# IAM Role for ECS Instances
#############################

resource "aws_iam_role" "ecs_instance" {

  name = "${var.project_name}-ecs-instance-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]

  })
}


resource "aws_iam_role_policy_attachment" "ecs_instance" {

  role = aws_iam_role.ecs_instance.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"

}


resource "aws_iam_instance_profile" "ecs" {

  name = "${var.project_name}-ecs-profile"

  role = aws_iam_role.ecs_instance.name

}


#############################
# ECS Cluster
#############################

resource "aws_ecs_cluster" "this" {

  name = "${var.project_name}-cluster"

}


#############################
# Launch Template
#############################

resource "aws_launch_template" "ecs" {

  name = "${var.project_name}-ecs-lt"


  image_id = var.ami_id


  instance_type = var.instance_type


  iam_instance_profile {

    name = aws_iam_instance_profile.ecs.name

  }


  user_data = base64encode(
<<EOF
#!/bin/bash

echo ECS_CLUSTER=${aws_ecs_cluster.this.name} \
>> /etc/ecs/ecs.config

EOF
  )


  security_group_names = [
    var.security_group_id
  ]

}


#############################
# Auto Scaling Group
#############################

resource "aws_autoscaling_group" "ecs" {

  name = "${var.project_name}-ecs-asg"

  min_size = var.min_size

  max_size = var.max_size

  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.private_subnet_ids

}
