## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.0.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener.alb_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.alb_targetgroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_ecr_repository.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_subnet_ids"></a> [alb\_subnet\_ids](#input\_alb\_subnet\_ids) | Subnets ID's where the ECS Service will run | `list(string)` | n/a | yes |
| <a name="input_alb_tg_green_port"></a> [alb\_tg\_green\_port](#input\_alb\_tg\_green\_port) | Port on which targets receive traffic, unless overridden when registering a specific target | `string` | `"8080"` | no |
| <a name="input_alb_tg_protocol"></a> [alb\_tg\_protocol](#input\_alb\_tg\_protocol) | Protocol to use for routing traffic to the targets | `string` | `"HTTP"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_container_definition"></a> [container\_definition](#input\_container\_definition) | A list of valid container definitions provided as a single valid JSON document | `string` | n/a | yes |
| <a name="input_container_insights"></a> [container\_insights](#input\_container\_insights) | n/a | `string` | `"enabled"` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Application container name | `string` | `"app"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port for app container | `string` | `"80"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Capacity in terms of cpu assigned to the task definition | `string` | `"1024"` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_ecs_subnet_ids"></a> [ecs\_subnet\_ids](#input\_ecs\_subnet\_ids) | Subnets ID's where the ECS Service will run | `list(string)` | n/a | yes |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL | `string` | `"FARGATE"` | no |
| <a name="input_lb_healthcheck_path"></a> [lb\_healthcheck\_path](#input\_lb\_healthcheck\_path) | Destination for the health check request. Required for HTTP/HTTPS ALB and HTTP NLB | `string` | `"/"` | no |
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | Determines whether load balancer is private or public | `bool` | `true` | no |
| <a name="input_lb_target_group_app_health_check_interval"></a> [lb\_target\_group\_app\_health\_check\_interval](#input\_lb\_target\_group\_app\_health\_check\_interval) | Approximate amount of time, in seconds, between health checks of an individual target | `number` | `30` | no |
| <a name="input_lb_target_group_app_health_check_timeout"></a> [lb\_target\_group\_app\_health\_check\_timeout](#input\_lb\_target\_group\_app\_health\_check\_timeout) | Amount of time, in seconds, during which no response from a target means a failed health check | `number` | `3` | no |
| <a name="input_lb_target_group_app_health_check_unhealthy_threshold"></a> [lb\_target\_group\_app\_health\_check\_unhealthy\_threshold](#input\_lb\_target\_group\_app\_health\_check\_unhealthy\_threshold) | Number of consecutive health check failures required before considering a target unhealthy | `number` | `3` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Capacity in terms of memory assigned to the task definition | `string` | `"2048"` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Docker networking mode to use for the containers in the task | `string` | `"awsvpc"` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are `NONE`, `SERVICE` and `TASK_DEFINITION`. | `string` | `"SERVICE"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Additional security group ids to be added to the ECS service. | `list(string)` | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | n/a | `string` | n/a | yes |
| <a name="input_terminate_blue_wait_mins"></a> [terminate\_blue\_wait\_mins](#input\_terminate\_blue\_wait\_mins) | The number of minutes to wait after a successful blue/green deployment before terminating instances from the original environment | `number` | `60` | no |
| <a name="input_tg_deregistration_delay"></a> [tg\_deregistration\_delay](#input\_tg\_deregistration\_delay) | Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. | `number` | `30` | no |
| <a name="input_tg_port"></a> [tg\_port](#input\_tg\_port) | Port on which targets receive traffic, unless overridden when registering a specific target | `string` | `"80"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC CIDR block | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Identifier of the VPC in which to create the target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_role_arn"></a> [ecs\_role\_arn](#output\_ecs\_role\_arn) | ECS role ARN |
| <a name="output_ecs_role_name"></a> [ecs\_role\_name](#output\_ecs\_role\_name) | ECS role name |
| <a name="output_ecs_service_cluster"></a> [ecs\_service\_cluster](#output\_ecs\_service\_cluster) | ECS service cluster |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | ECS service name |
