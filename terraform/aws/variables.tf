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

locals {
  account_id = var.account_ids[terraform.workspace]

  tags = {
    "Terraform"   = "true"
    "Repository"  = var.repository_name
    "Environment" = terraform.workspace
    "name"        = "csgtest"
  }
}