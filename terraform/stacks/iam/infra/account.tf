# We are using an AWS provider -- guess this is obvious !

terraform {
  backend "s3" {
    region     = "Set on command line with 'init -backend-config...'"
    bucket     = "Set on command line with 'init -backend-config...'"
    key        = "Set on command line with 'init -backend-config...'"
  }
}

#
# Default AWS provider for provisioning.
#
provider "aws" {
  region = var.region
}

#
# Local variables
#
locals {
  # Tag `Name` prefix
  prefix_name_tag = format("%s-%s-%s", var.env_profile, var.env_name, var.stack_name)

  # Default tags
  default_tags = {
    Profile = var.env_profile
    Environment = var.env_name
    Owner = var.env_owner
    Stack = var.stack_name
  }
 }