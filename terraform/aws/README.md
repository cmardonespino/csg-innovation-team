## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.0.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [template_file.container_definition](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_ids"></a> [account\_ids](#input\_account\_ids) | n/a | `map(string)` | <pre>{<br>  "development": "988650173498",<br>  "production": "",<br>  "staging": ""<br>}</pre> | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The AZ from AWS Subnets | `map(list(string))` | <pre>{<br>  "us-east-2": [<br>    "us-east-2a",<br>    "us-east-2b",<br>    "us-east-2c"<br>  ]<br>}</pre> | no |
| <a name="input_aws_role_name"></a> [aws\_role\_name](#input\_aws\_role\_name) | The role for the AWS Account | `string` | `"DeploymentInfrastructureRole"` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | n/a | `string` | `"csg-innovation-team"` | no |

## Outputs

No outputs.
