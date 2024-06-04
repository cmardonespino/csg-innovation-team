variable "workspace_rds_config_profile" {
  description = "Specific configuration by environment for the rds instance"
  type        = map(any)

  default = {
    development = {
      allocated_storage       = 20
      max_allocated_storage   = 100
      multi_az                = false
      maintenance_window      = "mon:16:01-mon:17:01"
      storage_encrypted       = true
      backup_retention_period = 0
      monitoring_interval     = 0
      skip_final_snapshot     = true
      instance_class          = "db.t3.micro"
    }
    staging = {
      allocated_storage       = 50
      max_allocated_storage   = 100
      multi_az                = false
      maintenance_window      = "mon:16:01-mon:17:01"
      storage_encrypted       = true
      backup_retention_period = 7
      monitoring_interval     = 60
      skip_final_snapshot     = false
      instance_class          = "db.t3.medium"
    }
    production = {
      allocated_storage       = 50
      max_allocated_storage   = 100
      multi_az                = true
      maintenance_window      = "tue:16:01-tue:17:01"
      storage_encrypted       = true
      backup_retention_period = 7
      monitoring_interval     = 60
      skip_final_snapshot     = false
      instance_class          = "db.m4.large"
    }
  }
}

# New database with postgres db 12
resource "aws_db_instance" "db" {
  identifier              = var.repository_name
  allocated_storage       = var.workspace_rds_config_profile[local.infra_environment]["allocated_storage"]
  max_allocated_storage   = var.workspace_rds_config_profile[local.infra_environment]["max_allocated_storage"]
  maintenance_window      = var.workspace_rds_config_profile[local.infra_environment]["maintenance_window"]
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "14.10"
  instance_class          = var.workspace_rds_config_profile[local.infra_environment]["instance_class"]
  multi_az                = var.workspace_rds_config_profile[local.infra_environment]["multi_az"]
  db_name                    = replace(var.repository_name, "-", "_")
  username                = "master"
  password                = var.db_instance_password[local.infra_environment]
  #storage_encrypted       = var.workspace_rds_config_profile[local.infra_environment]["storage_encrypted"]
  #backup_retention_period = var.workspace_rds_config_profile[local.infra_environment]["backup_retention_period"]
  monitoring_interval     = var.workspace_rds_config_profile[local.infra_environment]["monitoring_interval"]

  lifecycle {
    ignore_changes = [engine_version]
  }

  #monitoring_role_arn       = var.workspace_rds_config_profile[local.infra_environment]["monitoring_interval"] > 0 ? "arn:aws:iam::${local.environment_account}:role/rds-monitoring-role" : ""
  skip_final_snapshot       = var.workspace_rds_config_profile[local.infra_environment]["skip_final_snapshot"]
  final_snapshot_identifier = "${var.repository_name}-final-snapshot"

  # VPC and security configuration
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database.id]
  parameter_group_name   = aws_db_parameter_group.psql.name
  apply_immediately      = false

}