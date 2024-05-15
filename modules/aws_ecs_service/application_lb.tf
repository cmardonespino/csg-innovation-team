resource "aws_lb" "alb" {
  name = "${var.service_name}-alb"

  internal           = var.lb_internal
  load_balancer_type = "application"

  #security_groups = var.own_vpc ? [] : [aws_security_group.app.id]

  subnets = var.subnet_ids

  /*access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "${var.namespace}-alb-logs"
    enabled = true
  }

  depends_on = [aws_s3_bucket.alb_logs]*/

  tags = {
    "Name" = "${var.service_name}-alb"
  }
}

resource "aws_alb_target_group" "alb_targetgroup" {
  name   = "${var.service_name}-alb-tg"
  port   = var.tg_port
  vpc_id = var.vpc_id

  protocol             = var.alb_tg_protocol
  target_type          = "ip"
  deregistration_delay = var.tg_deregistration_delay



  health_check {
    path                = var.lb_healthcheck_path
    timeout             = var.lb_target_group_app_health_check_timeout
    interval            = var.lb_target_group_app_health_check_interval
    unhealthy_threshold = var.lb_target_group_app_health_check_unhealthy_threshold
  }

  tags = {
    "Name" = "${var.service_name}-alb-tg"
  }
}

resource "aws_alb_listener" "alb_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    "LoadBalancer" = aws_lb.alb.name
  }
}
