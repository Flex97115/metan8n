include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_terragrunt_dir()}/../../../modules/compute"
}

include "env" {
  path = "${get_terragrunt_dir()}/../../../modules/_env/compute.hcl"
}