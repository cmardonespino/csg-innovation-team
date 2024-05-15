# For allowed the specific AWS account ID based on the workspace to prevent you from mistakenly using an incorrect one
variable "aws_role_name" {
  type        = string
  description = "The role for the AWS Account"
  default     = "InfrastructureManagementRole"
}

provider "aws" {
  region  = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::${local.environment_account}:role/${var.aws_role_name}"
  }

  allowed_account_ids = [
    local.environment_account,
  ]
}

provider "aws" {
  region  = "us-east-1"
  alias   = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${local.environment_account}:role/${var.aws_role_name}"
  }

  allowed_account_ids = [
    local.environment_account,
  ]
}

terraform {
  backend "s3" {
    bucket               = "infra.vacasa.com"
    workspace_key_prefix = "yield/terraform/rates-tools-app/aws"

    // When using a non-default workspace, the state path will be /workspace_key_prefix/workspace_name/key
    // In this case if the workspace is development will be terraform/states/services/development/PROJECT_NAME.tfstate
    key = "terraform.tfstate"

    region  = "us-west-2"
    encrypt = true
    role_arn = "arn:aws:iam::197699921952:role/ProductYieldRole"
  }
}

data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}
