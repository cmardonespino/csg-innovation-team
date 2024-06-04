# For allowed the specific AWS account ID based on the workspace to prevent you from mistakenly using an incorrect one
variable "aws_role_name" {
  type        = string
  description = "The role for the AWS Account"
  default     = "DeploymentInfrastructureRole"
}

provider "aws" {
  region  = "us-east-2"

  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/${var.aws_role_name}"
  }

  allowed_account_ids = [
    local.account_id,
  ]

  default_tags {
    tags = local.tags
  }
}

terraform {
  backend "local" {
    path = "~/csg-innovation-team/terraform.tfstate"
  }
}
