variable "cluster_name" {
  type = string
  description = ""
}

variable "service_name" {
  type = string
  description = ""
}

variable "vpc_id" {
  type        = string
  description = "Identifier of the VPC in which to create the target group"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "lb_internal" {
  type        = bool
  description = "Determines whether load balancer is private or public"
  default     = true
}

variable "tg_port" {
  type        = string
  default     = "80"
  description = "Port on which targets receive traffic, unless overridden when registering a specific target"
}

variable "alb_tg_protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets"
  default     = "HTTP"
}

variable "alb_tg_green_port" {
  type        = string
  default     = "8080"
  description = "Port on which targets receive traffic, unless overridden when registering a specific target"
}

variable "tg_deregistration_delay" {
  type        = number
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused."
  default     = 30
}

variable "lb_healthcheck_path" {
  type        = string
  description = "Destination for the health check request. Required for HTTP/HTTPS ALB and HTTP NLB"
  default     = "/"
}

variable "lb_target_group_app_health_check_timeout" {
  type        = number
  description = "Amount of time, in seconds, during which no response from a target means a failed health check"
  default     = 3
}

variable "lb_target_group_app_health_check_interval" {
  type        = number
  description = "Approximate amount of time, in seconds, between health checks of an individual target"
  default     = 30
}

variable "lb_target_group_app_health_check_unhealthy_threshold" {
  type        = number
  description = "Number of consecutive health check failures required before considering a target unhealthy"
  default     = 3
}

variable "terminate_blue_wait_mins" {
  type        = number
  description = "The number of minutes to wait after a successful blue/green deployment before terminating instances from the original environment"
  default     = 60
}

variable "container_insights" {
  type = string
  description = ""
  default = "enabled"
}

variable "launch_type" {
  type        = string
  default     = "FARGATE"
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL"
}

variable "propagate_tags" {
  type        = string
  default     = "SERVICE"
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are `NONE`, `SERVICE` and `TASK_DEFINITION`."
}

variable "desired_count" {
  type        = number
  description = "Number of instances of the task definition to place and keep running"
  default     = 1
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets ID's where the ECS Service will run"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Additional security group ids to be added to the ECS service."
  default     = []
}

variable "container_name" {
  type        = string
  default     = "app"
  description = "Application container name"
}

variable "container_port" {
  type        = string
  default     = "80"
  description = "Port for app container"
}

variable "network_mode" {
  type        = string
  default     = "awsvpc"
  description = "Docker networking mode to use for the containers in the task"
}

variable "container_definition" {
  type        = string
  description = "A list of valid container definitions provided as a single valid JSON document"
}

variable "cpu" {
  type        = string
  default     = "1024"
  description = "Capacity in terms of cpu assigned to the task definition"
}

variable "memory" {
  type        = string
  default     = "2048"
  description = "Capacity in terms of memory assigned to the task definition"
}
