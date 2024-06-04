variable "account_ids" {
  type        = map(string)
  default     = {
    development = "988650173498"
    staging     = ""
    production  = ""
  }
}

variable "repository_name" {
  type = string
  default = "csg-innovation-team"
}

variable "db_instance_password" {
  description = "Master database password"
}

locals {
  account_id = var.account_ids[terraform.workspace]

  infra_environment = terraform.workspace

  tags = {
    "Terraform"   = "true"
    "Repository"  = var.repository_name
    "Environment" = local.infra_environment
    "name"        = "csgtest"
  }
}