# This module creates an ECS cluster and service with the specified configuration.
# The ECS cluster is used to run tasks and services, and the ECS service is used to manage the desired count of tasks.
resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = var.ecs_enable_container_insights # "enabled" or "disabled" or "enhanced"
  }
  tags = var.tags 
}

resource "aws_ecs_service" "service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cluster.name
  desired_count   = var.number_of_tasks
  launch_type     = var.ecs_launch_type # "FARGATE"
  task_definition = aws_ecs_task_definition.task_define.arn
  network_configuration {
    assign_public_ip    = var.ecs_assign_public_ip
    subnets             = var.ecs_subnet_ids # If public, use public subnets; if private, use private subnets 
    security_groups     = var.ecs_security_group_id
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn #aws_lb_target_group.app.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  tags = var.tags
  depends_on = [aws_lb_listener.listener]
}

# This module creates an ECS task definition with the specified container definitions and IAM role.
# Create the task definition with the specified container definitions and IAM role.
# The task definition is used to run tasks in ECS, and the IAM role is used to grant permissions to the task.
resource "aws_ecs_task_definition" "task_define" {
  family                   = var.task_definition_family_name
  requires_compatibilities = var.ecs_compatibilities_type
  network_mode             = var.ecs_network_mode # if using Fargate, set to "awsvpc"
  cpu                      = var.task_cpu          # CPU units for the task
  memory                   = var.task_memory       # Memory for the task
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "${var.container_name}"
      image     = "${aws_ecr_repository.ecr.repository_url}:latest"
      essential = true
      portMappings = [{
        containerPort = "${var.define_container_port}"
        hostPort      = "${var.define_host_port}"
      }]
    }
  ])
  tags = var.tags
}

resource "aws_iam_role" "ecs_task_execution" {
  name = var.ecs_task_execution_role
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = var.ecs_task_execution_policy_arn
}