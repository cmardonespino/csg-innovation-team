module "ecs_service" {
  source       = "../../modules/aws_ecs_service/"
  cluster_name = "csg-innovation-team"
  lb_internal = false
  service_name    = "csg-innovation-service"
  vpc_id = aws_vpc.vpc.id
  vpc_cidr_block = aws_vpc.vpc.cidr_block
  ecs_subnet_ids = [aws_subnet.private[0].id, aws_subnet.private[1].id]
  alb_subnet_ids = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  container_definition = data.template_file.container_definition.rendered
}

data "template_file" "container_definition" {
  template = file("ecs/example.json.tpl")
}