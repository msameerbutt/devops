# Declaration of variables that should be set in the *.tfvars file
# Common variables
variable "base_env_owner" {}
variable "base_env_name" {}
variable "base_env_region" {}
variable "env_profile" {}
variable "env_owner" {}
variable "env_name" {}
variable "stack_name" {
  default = "shared"
}
variable "region" {}
#=============================#
# Cloudwatch Billing alert    #
#=============================#
variable "create_sns_email" {
  description = "Email for billing alert"
  type        = string
  default     = "msameerbutt@gmail.com"
}
variable "create_sns_topic" {
  description = "Creates a SNS Topic if `true`."
  type        = bool
  default     = true
}
variable "sns_topic_arns" {
  description = "List of SNS topic ARNs to be used. If `create_sns_topic` is `true`, it merges the created SNS Topic by this module with this list of ARNs"
  type        = list(string)
  default     = []
}

variable "currency" {
  description = "Short notation for currency type (e.g. USD, CAD, EUR)"
  type        = string
  default     = "AUD"
}
variable "aws_account_id" {
  description = "AWS account id"
  type        = string
  default     = null
}
variable "monthly_billing_threshold" {
  description = "The threshold for which estimated monthly charges will trigger the metric alarm."
  type        = string
  default     = "30"
}
