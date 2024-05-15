variable "account_ids" {
  type        = map(string)
  default     = {
    development = "988650173498"
    staging     = ""
    production  = ""
  }
}

locals {
  account_id = var.account_ids[terraform.workspace]
}