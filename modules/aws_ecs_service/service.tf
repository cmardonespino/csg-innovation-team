resource "aws_ecs_service" "service" {
  name = var.service_name

  cluster = var.cluster_name

  launch_type = var.launch_type

  propagate_tags = var.propagate_tags

  desired_count = var.desired_count

  task_definition = aws_ecs_task_definition.app.family

  network_configuration {
    subnets          = var.ecs_subnet_ids
    security_groups  = length(var.security_group_ids) > 0 ? [aws_security_group.app.id, join(", ", var.security_group_ids)] : [aws_security_group.app.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_targetgroup.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
      desired_count
    ]
  }

  deployment_controller {
    type = "ECS"
  }

  depends_on = [
    aws_alb_listener.alb_http
  ]

  tags = {
    "Name" = "${var.service_name}"
  }
}

output "ecs_service_name" {
  description = "ECS service name"
  value = aws_ecs_service.service.name
}

output "ecs_service_cluster" {
  description = "ECS service cluster"
  value = aws_ecs_service.service.cluster
}