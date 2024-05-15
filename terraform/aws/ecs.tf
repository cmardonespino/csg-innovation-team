module "ecs_service" {
  source       = "../../modules/aws_ecs_service/"
  cluster_name = "csg-innovation-team"
  service_name    = "csg-innovation-service"
  vpc_id = data.aws_vpc.vpc.id
  vpc_cidr_block = data.aws_vpc.vpc.cidr_block
  subnet_ids = data.aws_subnet_ids.subnets.ids
  container_definition = data.template_file.container_definition.rendered
}

data "template_file" "container_definition" {
  template = file("ecs/example.json.tpl")
}