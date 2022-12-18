//Create Cluster
resource "aws_ecs_cluster" "cluster" {
  name = var.clustername
}

//Create Task Definition
resource "aws_ecs_task_definition" "task_definition" {
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  family                   = "wp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  task_role_arn            = aws_iam_role.ecsrole.arn
  container_definitions = jsonencode([
    {
      name  = "wp"
      image = "wordpress:latest"
      cpu : 512
      memory      = 512
      networkMode = "awsvpc"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
      ],
      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = data.aws_ssm_parameter.dbhost.value
        },
        {
          name  = "WORDPRESS_DB_NAME"
          value = data.aws_ssm_parameter.dbname.value
        },
        {
          name  = "WORDPRESS_DB_USER"
          value = data.aws_ssm_parameter.dbuser.value
        }
      ]
      secrets = [
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = data.aws_ssm_parameter.dbpassword.arn
        }
      ]
    }
    ]
  )
}

//Create ECS Service
resource "aws_ecs_service" "ecs-service" {
  name            = "wp"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 2
  launch_type     = "EC2"

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_task.id]
    subnets          = var.subnet_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target.arn
    container_name   = "wp"
    container_port   = 80
  }

  # depends_on = [aws_lb_listener.front_end]
  depends_on = [aws_lb_listener.https]
}
