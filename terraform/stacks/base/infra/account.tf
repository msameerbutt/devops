# We are using an AWS provider -- guess this is obvious !

terraform {
  backend "s3" {
    region = "Set on command line with 'init -backend-config...'"
    bucket = "Set on command line with 'init -backend-config...'"
    key    = "Set on command line with 'init -backend-config...'"
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
  prefix_name_tag = format("%s-%s-%s", var.organization, var.environment, var.service)

  # Default tags
  default_tags = {
    environment     = var.environment
    service         = var.service
    technical_owner = var.technical_owner
    stack_name      = var.stack_name
  }
}
