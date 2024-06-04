resource "aws_ecs_task_definition" "app" {
  family                = "${var.service_name}-ecs-app"
  network_mode          = var.network_mode
  container_definitions = var.container_definition
  execution_role_arn    = aws_iam_role.ecs_role.arn
  task_role_arn         = aws_iam_role.ecs_role.arn

  requires_compatibilities = [var.launch_type]

  cpu    = var.cpu
  memory = var.memory

  depends_on = [aws_iam_role.ecs_role]

  lifecycle {
    ignore_changes = [container_definitions]
  }

  tags = {
    "Name" = "${var.service_name}-ecs-app"
  }
}