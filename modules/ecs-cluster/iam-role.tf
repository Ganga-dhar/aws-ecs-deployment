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
