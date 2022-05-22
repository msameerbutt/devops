# Declaration of variables that should be set in the *.tfvars file
# Common variables
variable "base_env_owner" {}
variable "base_env_name" {}
variable "base_env_region" {}
variable "env_profile" {}
variable "env_owner" {}
variable "env_name" {}
variable "stack_name" {
    default = "iam"
}
variable "region" {}