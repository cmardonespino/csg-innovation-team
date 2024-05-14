resource "aws_ecs_service" "service" {
  name = var.namespace

  cluster = var.cluster_name

  launch_type = var.launch_type

  propagate_tags = var.propagate_tags

  desired_count = var.desired_count

  task_definition = aws_ecs_task_definition.app.family

  network_configuration {
    subnets          = var.private_subnet_ids
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
    type = var.codedeploy == true ? "CODE_DEPLOY" : "ECS"
  }

  depends_on = [
    aws_route53_record.application_domain,
    aws_acm_certificate.application_domain,
    aws_alb_listener.alb_https
  ]

  tags = var.default_tags ? merge({ "Name" = "${var.namespace}-ecs-service" }) : merge(
    var.tags,
    {
      "Name" = "${var.namespace}-ecs-service"
    },
  )
}

resource "aws_ecs_task_definition" "app" {
  family                = "${var.namespace}-ecs-app"
  network_mode          = var.network_mode
  container_definitions = var.container_definition
  execution_role_arn    = aws_iam_role.ecs_task_role.arn
  task_role_arn         = aws_iam_role.ecs_task_role.arn

  requires_compatibilities = [var.launch_type]

  cpu    = var.cpu
  memory = var.memory

  depends_on = [aws_iam_role.ecs_task_role]

  lifecycle {
    ignore_changes = [container_definitions]
  }

  tags = var.default_tags ? merge({ "Name" = "${var.namespace}-task-definition" }) : merge(
    var.tags,
    {
      "Name" = "${var.namespace}-task-definition"
    },
  )
}

output "service_name" {
  value = aws_ecs_service.service.name
}
