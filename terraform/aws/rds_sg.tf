resource "aws_security_group" "database" {
  name        = "${var.repository_name}-sg"
  description = "Allow Traffic to DB (Postgresql)"
  vpc_id      = aws_vpc.vpc.id

  tags = { "Name" = "${var.repository_name}-sg" }
}

resource "aws_security_group_rule" "ingress_connection_from_vpc" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.vpc.cidr_block]
  security_group_id = aws_security_group.database.id
}