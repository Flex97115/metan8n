locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  project_name = "metan8n"
  aws_region   = local.environment_vars.locals.aws_region
  environment  = local.environment_vars.locals.environment
  oci_region   = local.environment_vars.locals.oci_region
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "oci" {
  region = "${local.oci_region}"
}

provider "aws" {
  region = "${local.aws_region}"
  profile = "terraform"
}
EOF
}

generate "terraform_version" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = ">= 6.21.0"
    }
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.project_name}-${local.environment}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "${local.project_name}-${local.environment}-terragrunt-state-lock"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.environment_vars.locals,
)